require 'spec_helper'

describe FireAlert do
  include DataSupport

  it { should validate_presence_of :address }
  it { should validate_presence_of :datetime }
  it { should validate_presence_of :incident_number }
  it { should validate_presence_of :fire_type }
  it { should validate_presence_of :latitude }
  it { should validate_presence_of :longitude }
  it { should validate_presence_of :time_show }

  it { should validate_uniqueness_of :incident_number }

  it { should have_many(:subscribers).through(:fire_notifications) }

  describe '.parse_fire_data(raw_fire_data)' do
    it 'parses raw data and creates record' do
      FireAlert.parse_data(raw_fire_data)
      fire_alert = FireAlert.find_by(incident_number: "F150019090")
      expect(fire_alert.address).to eq("1000 4th Av")
    end
  end             
end
