class TripSeparatorWorker
  include Sidekiq::Worker
  #sidekiq_options unique: true

  def perform(user_id)
    user = User.find_by_id user_id
    if user
      TripSeparator.new(user).calc_and_save_trips
    end    
  end
end