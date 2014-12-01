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

  array = [{"address"=>"1320 Nw 75th St",
             "longitude"=>"-122.372835",
             "latitude"=>"47.683247",
             "incident_number"=>"F140130546",
             "datetime"=>"Sun Nov 30, 2014 at 12:13 PM",
             "time_show"=>"2014-11-30 12:13:00 -0800",
             "fire_type"=>"Auto Fire Alarm"}, {"address"=>"7711 43rd Av Ne",
             "longitude"=>"-122.282094",
             "latitude"=>"47.684910",
             "incident_number"=>"F140130550",
             "datetime"=>"Sun Nov 30, 2014 at 12:27 PM",
             "time_show"=>"2014-11-30 12:27:00 -0800",
             "fire_type"=>"Auto Fire Alarm"}]

  describe '.parse_fire_data(array)' do

    it 'parses array of JSON objects from the SODA API' do
      FireAlert.all.each {|f| f.destroy }
      FireAlert.parse_fire_data(array)
      binding.pry
      expect(FireAlert.count).to eq(2)
    end

    it 'saves the data in psql' do
      FireAlert.all.each {|f| f.destroy }
      FireAlert.parse_fire_data(array)
      expect(FireAlert.first.address).to eq("1320 Nw 75th St")
    end
  end             
end
