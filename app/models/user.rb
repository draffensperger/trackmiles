class User < ActiveRecord::Base
  include Async

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :locations
  has_many :calendar_users
  has_many :trips
  has_many :places
  has_many :calendars, through: :calendar_users

  # has_many :trip_separator_regions, autosave: true
  has_one :trip_separator_region, autosave: true
  belongs_to :last_stop_region, class_name: 'TripSeparatorRegion',
                                foreign_key: 'last_stop_region_id'
  belongs_to :current_region, class_name: 'TripSeparatorRegion',
                              foreign_key: 'current_region_id'

  def self.find_for_google_oauth2(access_token, _signed_in_resource = nil)
    find_or_build_for_google_userinfo(access_token.info)
  end

  def self.find_or_build_for_google_token(token)
    find_or_build_for_google_userinfo(
      get_userinfo_for_google_token(token)
    )
  end

  def self.find_or_build_for_google_userinfo(userinfo)
    if userinfo.nil? || !userinfo.key?('email') ||
       userinfo['email'].nil? || userinfo['email'] == ''

      return nil
    end

    user = User.where(email: userinfo['email']).first
    unless user
      user = User.new(
        name: userinfo['name'],
        email: userinfo['email'],
        provider: 'google',
        password: Devise.friendly_token[0, 20]
      )
    end
    user
  end

  def self.get_userinfo_for_google_token(token)
    url = 'https://www.googleapis.com/oauth2/v1/userinfo'

    begin
      JSON.parse RestClient.get url, params: { access_token: token }
    rescue RestClient::Unauthorized
      nil
    rescue => e
      # Other exceptions e.g. network problems will also cause a return of nil.
      nil
    end
  end

  def place_for_location(loc)
    nearest_place_at(loc) || create_place_for_location(loc)
  end

  def create_place_for_location(loc)
    place = Place.new latitude: loc.latitude, longitude: loc.longitude,
                      user: self
    place.reverse_geocode
    place.save
    place
  end

  def same_place_radius_km
    # For now just use a constant
    0.5
  end

  def places_at(loc)
    places.near [loc.latitude, loc.longitude], same_place_radius_km
  end

  def nearest_place_at(loc)
    GeometryUtil.closest_by_degrees_sq loc, places_at(loc)
  end

  def sync_calendars
    @sync_calendars ||= SyncCalendars.new(self)
    @sync_calendars.sync_calendars
  end

  def google_api
    @google_api ||= GoogleApi.new(self)
  end

  def calc_and_save_trips_async
    Rails.logger.debug 'User.calc_and_save_trips_async'
    async(:calc_and_save_trips)
  end

  def calc_and_save_trips
    Rails.logger.debug 'User.calc_and_save_trips'
    TripSeparator.new(self).calc_and_save_trips
  end
end
