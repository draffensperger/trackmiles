require File.expand_path("../../../../spec_helper", __FILE__)

# Adapted from:
# See http://pivotallabs.com/adding-routes-for-tests-specs-with-rails-3/

class Api::V1::InheritsFromBaseController < Api::V1::BaseController
  def index
    render :text => "Test"
  end
end

describe Api::V1::InheritsFromBaseController, :type => :controller do
  before do    
    Rails.application.routes.draw do
      namespace :api do
        namespace :v1 do
          resources :inherits_from_base, only: [:index]
        end
      end
    end
  end
  
  after do
    Rails.application.reload_routes!
  end
      
  it "should return http unauthorized without google auth token" do      
    get :index
    response.response_code.should == 401    
    response.body.should == {errors: ['Missing access token']}.to_json    
  end
  
  it "should return http unauthorized with invalid google token" do    
    get :index, google_token: stub_invalid_google_token
    response.response_code.should == 401
    response.body.should == {errors: ['Invalid access token']}.to_json    
  end
  
  it "should succeed with valid google token" do
    get :index, google_token: stub_google_token
    response.should be_success
    response.body.should == "Test"
    subject.current_user.should == user_for_stubbed_login
  end
end
