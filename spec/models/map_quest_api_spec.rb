require 'spec_helper'

describe MapQuestApi do
  before do
    @url = 'http://open.mapquestapi.com/directions/v2/route'
    @query = {'key' => ENV['MAPQUEST_API_KEY'],
             'unit' => 'k',
             'routeType' => 'shortest',
             'from' => '38.8941,-77.07556',
             'to' => '38.84458,-77.07823'}
  end

  it 'should get correct distance' do
    # Pasted in from MapQuest URL response (with API key removed)
    response = '{"route":{"hasTollRoad":false,"computedWaypoints":[],"fuelUsed":0.28,"hasUnpaved":false,"hasHighway":true,"realTime":-1,"boundingBox":{"ul":{"lng":-77.079917,"lat":38.894428},"lr":{"lng":-77.059623,"lat":38.844795}},"distance":7.2501,"time":438,"locationSequence":[0,1],"hasSeasonalClosure":false,"sessionId":"53727352-0162-0003-02b7-11a1-00163ec01eda","locations":[{"latLng":{"lng":-77.07556,"lat":38.8941},"adminArea4":"Arlington County","adminArea5Type":"City","adminArea4Type":"County","adminArea5":"Arlington","street":"Clarendon Boulevard","adminArea1":"US","adminArea3":"VA","type":"s","displayLatLng":{"lng":-77.07556,"lat":38.8941},"linkId":41910239,"postalCode":"22201","sideOfStreet":"N","dragPoint":false,"adminArea1Type":"Country","geocodeQuality":"ADDRESS","geocodeQualityCode":"L1AAA","adminArea3Type":"State"},{"latLng":{"lng":-77.07823,"lat":38.84458},"adminArea4":"Arlington County","adminArea5Type":"City","adminArea4Type":"County","adminArea5":"Arlington","street":"South Glebe Road","adminArea1":"US","adminArea3":"VA","type":"s","displayLatLng":{"lng":-77.07823,"lat":38.84458},"linkId":51706150,"postalCode":"22206","sideOfStreet":"N","dragPoint":false,"adminArea1Type":"Country","geocodeQuality":"ADDRESS","geocodeQualityCode":"L1AAA","adminArea3Type":"State"}],"hasCountryCross":false,"legs":[{"hasTollRoad":false,"index":0,"roadGradeStrategy":[[]],"hasHighway":true,"hasUnpaved":false,"distance":7.2501,"time":438,"origIndex":3,"hasSeasonalClosure":false,"origNarrative":"Go south on VA-110 S/N Jefferson Davis Hwy.","hasCountryCross":false,"formattedTime":"00:07:18","destNarrative":"","destIndex":-1,"maneuvers":[{"signs":[],"index":0,"maneuverNotes":[],"direction":6,"narrative":"Start out going southwest toward Clarendon Blvd.","iconUrl":"http://content.mapquest.com/mqsite/turnsigns/icon-dirs-start_sm.gif","distance":0.0531,"time":39,"linkIds":[],"streets":[],"attributes":0,"transportMode":"AUTO","formattedTime":"00:00:39","directionName":"Southwest","mapUrl":"http://open.mapquestapi.com/staticmap/v4/getmap?key=YOUR_API_KEY&type=map&size=225,160&pois=purple-1,38.893825,-77.075515,0,0|purple-2,38.893577,-77.075897,0,0|&center=38.893701,-77.075706&zoom=15&rand=-791837429&session=53727352-0162-0003-02b7-11a1-00163ec01eda","startPoint":{"lng":-77.075515,"lat":38.893825},"turnType":0},{"signs":[],"index":1,"maneuverNotes":[],"direction":3,"narrative":"Turn left onto Clarendon Blvd.","iconUrl":"http://content.mapquest.com/mqsite/turnsigns/rs_left_sm.gif","distance":0.206,"time":17,"linkIds":[],"streets":["Clarendon Blvd"],"attributes":0,"transportMode":"AUTO","formattedTime":"00:00:17","directionName":"Northeast","mapUrl":"http://open.mapquestapi.com/staticmap/v4/getmap?key=YOUR_API_KEY&type=map&size=225,160&pois=purple-2,38.893577,-77.075897,0,0|purple-3,38.894428,-77.073898,0,0|&center=38.8940025,-77.07489749999999&zoom=14&rand=-791837429&session=53727352-0162-0003-02b7-11a1-00163ec01eda","startPoint":{"lng":-77.075897,"lat":38.893577},"turnType":6},{"signs":[],"index":2,"maneuverNotes":[],"direction":8,"narrative":"Clarendon Blvd becomes N Clarendon Blvd.","iconUrl":"http://content.mapquest.com/mqsite/turnsigns/rs_straight_sm.gif","distance":0.5472,"time":67,"linkIds":[],"streets":["N Clarendon Blvd"],"attributes":0,"transportMode":"AUTO","formattedTime":"00:01:07","directionName":"East","mapUrl":"http://open.mapquestapi.com/staticmap/v4/getmap?key=YOUR_API_KEY&type=map&size=225,160&pois=purple-3,38.894428,-77.073898,0,0|purple-4,38.893848,-77.06828999999999,0,0|&center=38.894138,-77.07109399999999&zoom=12&rand=-791837429&session=53727352-0162-0003-02b7-11a1-00163ec01eda","startPoint":{"lng":-77.073898,"lat":38.894428},"turnType":0},{"signs":[{"text":"110","extraText":"","direction":4,"type":545,"url":"http://icons.mqcdn.com/icons/rs545.png?n=110&d=SOUTH"}],"index":3,"maneuverNotes":[],"direction":4,"narrative":"N Clarendon Blvd becomes VA-110 S/N Jefferson Davis Hwy.","iconUrl":"http://content.mapquest.com/mqsite/turnsigns/rs_slight_right_sm.gif","distance":1.8459,"time":77,"linkIds":[],"streets":["VA-110 S","N Jefferson Davis Hwy"],"attributes":128,"transportMode":"AUTO","formattedTime":"00:01:17","directionName":"South","mapUrl":"http://open.mapquestapi.com/staticmap/v4/getmap?key=YOUR_API_KEY&type=map&size=225,160&pois=purple-4,38.893848,-77.06828999999999,0,0|purple-5,38.879188,-77.059623,0,0|&center=38.886517999999995,-77.06395649999999&zoom=9&rand=-791837429&session=53727352-0162-0003-02b7-11a1-00163ec01eda","startPoint":{"lng":-77.06829,"lat":38.893848},"turnType":1},{"signs":[{"text":"27","extraText":"","direction":7,"type":545,"url":"http://icons.mqcdn.com/icons/rs545.png?n=27&d=WEST"}],"index":4,"maneuverNotes":[],"direction":7,"narrative":"Merge onto VA-27 W/Washington Blvd.","iconUrl":"http://content.mapquest.com/mqsite/turnsigns/rs_merge_right_sm.gif","distance":1.751,"time":89,"linkIds":[],"streets":["VA-27 W","Washington Blvd"],"attributes":128,"transportMode":"AUTO","formattedTime":"00:01:29","directionName":"West","mapUrl":"http://open.mapquestapi.com/staticmap/v4/getmap?key=YOUR_API_KEY&type=map&size=225,160&pois=purple-5,38.879188,-77.059623,0,0|purple-6,38.866577,-77.06633699999999,0,0|&center=38.8728825,-77.06298&zoom=9&rand=-791837429&session=53727352-0162-0003-02b7-11a1-00163ec01eda","startPoint":{"lng":-77.059623,"lat":38.879188},"turnType":10},{"signs":[{"text":"395","extraText":"","direction":4,"type":1,"url":"http://icons.mqcdn.com/icons/rs1.png?n=395&d=SOUTH"}],"index":5,"maneuverNotes":[],"direction":4,"narrative":"Merge onto I-395 S/Shirley Hwy via the exit on the left.","iconUrl":"http://content.mapquest.com/mqsite/turnsigns/rs_merge_left_sm.gif","distance":1.936,"time":84,"linkIds":[],"streets":["I-395 S","Shirley Hwy"],"attributes":128,"transportMode":"AUTO","formattedTime":"00:01:24","directionName":"South","mapUrl":"http://open.mapquestapi.com/staticmap/v4/getmap?key=YOUR_API_KEY&type=map&size=225,160&pois=purple-6,38.866577,-77.06633699999999,0,0|purple-7,38.851366999999996,-77.075813,0,0|&center=38.858971999999994,-77.071075&zoom=9&rand=-791837429&session=53727352-0162-0003-02b7-11a1-00163ec01eda","startPoint":{"lng":-77.066337,"lat":38.866577},"turnType":11},{"signs":[{"text":"7","extraText":"","direction":0,"type":1001,"url":"http://icons.mqcdn.com/icons/rs1001.png?n=7&d=RIGHT"}],"index":6,"maneuverNotes":[],"direction":6,"narrative":"Take EXIT 7.","iconUrl":"http://content.mapquest.com/mqsite/turnsigns/rs_gr_exitright_sm.gif","distance":0.3283,"time":17,"linkIds":[],"streets":[],"attributes":0,"transportMode":"AUTO","formattedTime":"00:00:17","directionName":"Southwest","mapUrl":"http://open.mapquestapi.com/staticmap/v4/getmap?key=YOUR_API_KEY&type=map&size=225,160&pois=purple-7,38.851366999999996,-77.075813,0,0|purple-8,38.848934,-77.077941,0,0|&center=38.8501505,-77.076877&zoom=12&rand=-791837429&session=53727352-0162-0003-02b7-11a1-00163ec01eda","startPoint":{"lng":-77.075813,"lat":38.851367},"turnType":14},{"signs":[],"index":7,"maneuverNotes":[],"direction":6,"narrative":"Keep right at the fork in the ramp.","iconUrl":"http://content.mapquest.com/mqsite/turnsigns/rs_fork_right2_sm.gif","distance":0.2028,"time":11,"linkIds":[],"streets":[],"attributes":0,"transportMode":"AUTO","formattedTime":"00:00:11","directionName":"Southwest","mapUrl":"http://open.mapquestapi.com/staticmap/v4/getmap?key=YOUR_API_KEY&type=map&size=225,160&pois=purple-8,38.848934,-77.077941,0,0|purple-9,38.84769,-77.079627,0,0|&center=38.848312,-77.078784&zoom=13&rand=-792222178&session=53727352-0162-0003-02b7-11a1-00163ec01eda","startPoint":{"lng":-77.077941,"lat":38.848934},"turnType":16},{"signs":[],"index":8,"maneuverNotes":[],"direction":6,"narrative":"Keep left at the fork in the ramp.","iconUrl":"http://content.mapquest.com/mqsite/turnsigns/rs_fork_left2_sm.gif","distance":0.0306,"time":17,"linkIds":[],"streets":[],"attributes":0,"transportMode":"AUTO","formattedTime":"00:00:17","directionName":"Southwest","mapUrl":"http://open.mapquestapi.com/staticmap/v4/getmap?key=YOUR_API_KEY&type=map&size=225,160&pois=purple-9,38.84769,-77.079627,0,0|purple-10,38.847533999999996,-77.079917,0,0|&center=38.847612,-77.07977199999999&zoom=15&rand=-792222178&session=53727352-0162-0003-02b7-11a1-00163ec01eda","startPoint":{"lng":-77.079627,"lat":38.84769},"turnType":17},{"signs":[{"text":"120","extraText":"","direction":0,"type":545,"url":"http://icons.mqcdn.com/icons/rs545.png?n=120"}],"index":9,"maneuverNotes":[],"direction":5,"narrative":"Turn left onto VA-120/S Glebe Rd.","iconUrl":"http://content.mapquest.com/mqsite/turnsigns/rs_left_sm.gif","distance":0.3492,"time":20,"linkIds":[],"streets":["VA-120","S Glebe Rd"],"attributes":0,"transportMode":"AUTO","formattedTime":"00:00:20","directionName":"Southeast","mapUrl":"http://open.mapquestapi.com/staticmap/v4/getmap?key=YOUR_API_KEY&type=map&size=225,160&pois=purple-10,38.847533999999996,-77.079917,0,0|purple-11,38.844795,-77.07794899999999,0,0|&center=38.8461645,-77.07893299999999&zoom=12&rand=-792222178&session=53727352-0162-0003-02b7-11a1-00163ec01eda","startPoint":{"lng":-77.079917,"lat":38.847534},"turnType":6},{"signs":[],"index":10,"maneuverNotes":[],"direction":0,"narrative":"SOUTH GLEBE ROAD.","iconUrl":"http://content.mapquest.com/mqsite/turnsigns/icon-dirs-end_sm.gif","distance":0,"time":0,"linkIds":[],"streets":[],"attributes":0,"transportMode":"AUTO","formattedTime":"00:00:00","directionName":"","startPoint":{"lng":-77.077949,"lat":38.844795},"turnType":-1}],"hasFerry":false}],"formattedTime":"00:07:18","routeError":{"message":"","errorCode":-400},"options":{"mustAvoidLinkIds":[],"drivingStyle":2,"countryBoundaryDisplay":true,"generalize":-1,"narrativeType":"text","locale":"en_US","avoidTimedConditions":false,"destinationManeuverDisplay":true,"enhancedNarrative":false,"filterZoneFactor":-1,"timeType":0,"maxWalkingDistance":-0.621371,"routeType":"FASTEST","transferPenalty":-1,"stateBoundaryDisplay":true,"walkingSpeed":-0.621371,"maxLinkId":0,"arteryWeights":[],"tryAvoidLinkIds":[],"unit":"K","routeNumber":0,"shapeFormat":"raw","maneuverPenalty":-1,"useTraffic":false,"returnLinkDirections":false,"avoidTripIds":[],"manmaps":"true","highwayEfficiency":22,"sideOfStreetDisplay":true,"cyclingRoadFactor":1,"urbanAvoidFactor":-1},"hasFerry":false},"info":{"copyright":{"text":"(c) 2014 MapQuest, Inc.","imageUrl":"http://api.mqcdn.com/res/mqlogo.gif","imageAltText":"(c) 2014 MapQuest, Inc."},"statuscode":0,"messages":[]}}'

    req = stub_request(:get, @url).with(:query => @query)
      .to_return(:body => response, :status => 200)

    MapQuestApi.distance('38.8941,-77.07556', '38.84458,-77.07823')
      .should eq 7.2501

    req.should have_been_requested
  end

  it 'should handle error response from server' do
    req = stub_request(:get, @url).with(:query => @query)
      .to_return(:body => '{}', :status => 500)

    MapQuestApi.distance('38.8941,-77.07556', '38.84458,-77.07823')
      .should be_nil

    req.should have_been_requested
  end

  it 'should handle badly formed response' do
    req = stub_request(:get, @url).with(:query => @query)
    .to_return(:body => 'bad response', :status => 200)

    MapQuestApi.distance('38.8941,-77.07556', '38.84458,-77.07823')
    .should be_nil

    req.should have_been_requested
  end
end
