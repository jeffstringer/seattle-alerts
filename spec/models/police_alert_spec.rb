require 'spec_helper'

describe PoliceAlert do

  it { should validate_presence_of :hundred_block_location }
  it { should validate_presence_of :event_clearance_description }
  it { should validate_presence_of :event_clearance_date }
  it { should validate_presence_of :general_offense_number }
  it { should validate_presence_of :census_tract }
  it { should validate_presence_of :latitude }
  it { should validate_presence_of :longitude }
  it { should validate_presence_of :time_show }

  it { should validate_uniqueness_of :general_offense_number }

  it { should have_many(:subscribers).through(:police_notifications) }

  array = [{"event_clearance_code"=>"177",
                                  "cad_event_number"=>"14000396695",
                                  "event_clearance_subgroup"=>"LIQUOR VIOLATIONS",
                                  "event_clearance_group"=>"LIQUOR VIOLATIONS",
                                  "cad_cdw_id"=>"2211952",
                                  "event_clearance_date"=>"2013-11-28T08:43:00",
                                  "zone_beat"=>"E1",
                                  "initial_type_description"=>"DETOX - REQUEST FOR",
                                  "district_sector"=>"E",
                                  "initial_type_subgroup"=>"LIQUOR VIOLATIONS",
                                  "incident_location"=>{"needs_recoding"=>false, "longitude"=>"-122.320863689", "latitude"=>"47.619323645"},
                                  "hundred_block_location"=>"1XX BLOCK OF BROADWAY E",
                                  "general_offense_number"=>"2014396695",
                                  "event_clearance_description"=>"LIQUOR VIOLATION - INTOXICATED PERSON",
                                  "longitude"=>"-122.320863689",
                                  "latitude"=>"47.619323645",
                                  "initial_type_group"=>"LIQUOR VIOLATIONS",
                                  "census_tract"=>"7400.3005"},
                                 {"event_clearance_code"=>"245",
                                  "cad_event_number"=>"14000396683",
                                  "event_clearance_subgroup"=>"DISTURBANCES",
                                  "event_clearance_group"=>"DISTURBANCES",
                                  "cad_cdw_id"=>"2211938",
                                  "event_clearance_date"=>"2013-11-28T08:31:00",
                                  "zone_beat"=>"G2",
                                  "initial_type_description"=>"DISTURBANCE, MISCELLANEOUS/OTHER",
                                  "district_sector"=>"G",
                                  "initial_type_subgroup"=>"DISTURBANCES",
                                  "incident_location"=>{"needs_recoding"=>false, "longitude"=>"-122.31276312", "latitude"=>"47.597490885"},
                                  "hundred_block_location"=>"RAINIER AV S / S WELLER ST",
                                  "general_offense_number"=>"2014396683",
                                  "event_clearance_description"=>"DISTURBANCE, OTHER",
                                  "longitude"=>"-122.312763120",
                                  "latitude"=>"47.597490885",
                                  "initial_type_group"=>"DISTURBANCES",
                                  "census_tract"=>"9000.2004"}]

  describe '.parse_police_data(array)' do

    before do
      PoliceAlert.all.each {|p| p.destroy }
      PoliceAlert.parse_police_data(array)
    end

    it 'parses array of JSON objects from the SODA API' do
      expect(PoliceAlert.count).to eq(2)
    end

    it 'saves the data in psql' do
      expect(PoliceAlert.first.hundred_block_location).to eq("1XX BLOCK OF BROADWAY E")
    end
  end
end
