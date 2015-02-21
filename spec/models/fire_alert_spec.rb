require 'spec_helper'

describe FireAlert do

  it { should validate_presence_of :address }
  it { should validate_presence_of :datetime }
  it { should validate_presence_of :incident_number }
  it { should validate_presence_of :fire_type }
  it { should validate_presence_of :latitude }
  it { should validate_presence_of :longitude }
  it { should validate_presence_of :time_show }

  it { should validate_uniqueness_of :incident_number }

  it { should have_many(:subscribers).through(:fire_notifications) }

  array = [
            {"address"=>"1000 4th Av",
            "longitude"=>"-122.332909",
            "latitude"=>"47.606088",
            "incident_number"=>"F150019090",
            "datetime"=>1424468700,
            "type"=>"Auto Fire Alarm",
            "report_location"=>{"needs_recoding"=>false, "longitude"=>"-122.332909", "latitude"=>"47.606088"}},
            {"address"=>"3715 West Stevens Way Ne",
            "longitude"=>"-122.307565",
            "latitude"=>"47.652021",
            "incident_number"=>"F150019128",
            "datetime"=>1424475660,
            "type"=>"Auto Fire Alarm",
            "report_location"=>{"needs_recoding"=>false, "longitude"=>"-122.307565", "latitude"=>"47.652021"}}]

  describe '.parse_fire_data(array)' do
    it 'saves the data in psql' do
      PoliceAlert.destroy_all
      FireAlert.parse_fire_data(array)
      expect(FireAlert.first.address).to eq("1000 4th Av")
    end
  end             
end
