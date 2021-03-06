require File.expand_path('../../spec_helper', __FILE__)

describe 'post sample data and correctly separate trips', type: :request do
  self.use_transactional_fixtures = false

  before do
    WebMock.disable!
    @token = stub_google_token
  end
  after do
    ActiveRecord::Base.subclasses.each(&:delete_all)
    WebMock.enable!
  end

  def check_trips(trips, expected_trip_attrs)
    trips.length.should eq expected_trip_attrs.length
    trips.each_with_index do |a, i|
      e = expected_trip_attrs[i]
      a.start_time.should eq(e[:start_time])
      a.end_time.should eq(e[:end_time])
      d = 0.0002
      a.start_place.latitude.should be_within(d).of(e[:start_latitude].to_f)
      a.start_place.longitude.should be_within(d).of(e[:start_longitude].to_f)
      a.end_place.latitude.should be_within(d).of(e[:end_latitude].to_f)
      a.end_place.longitude.should be_within(d).of(e[:end_longitude].to_f)
      a.distance.should be_within(0.1).of(e[:distance].to_f)
    end
  end

  def post_locations_expect_trips(dataset, batch_size, worker_run_on_nth)
    data_dir = "spec/data/trip_separation/#{dataset}/"
    trip_attrs = CSVUtil.load_as_hashes(data_dir + 'trips.csv')
    all_locs = CSVUtil.load_as_hashes(data_dir + 'locations.csv')

    all_locs.each_slice(batch_size).with_index do |(*locs), i|
      post '/api/v1/locations/bulk_create', google_token: @token, locations: locs
      expect(response).to be_success
      expect(response.body).to eq({num_created_locations: locs.length}.to_json)

      if worker_run_on_nth and (i + 1) % worker_run_on_nth == 0
        Async.wait_for_all_jobs
      end
    end
    Async.wait_for_all_jobs

    get trips_path
    response.should be_success
    check_trips assigns(:trips), trip_attrs
  end

  it 'separates day 1 trips, locations loaded at once' do
    post_locations_expect_trips 'day1', 1000000, nil
  end

  it 'separates day 1 trips, locations in batches, worker every 4 batches' do
    post_locations_expect_trips 'day1', 32, 4
  end
end