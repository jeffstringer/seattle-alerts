require 'spec_helper'

describe PoliceAlert do
  include DataSupport

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

  describe '.parse_data(array)' do
    it 'saves the data in psql' do
      PoliceAlert.destroy_all
      PoliceAlert.parse_data(raw_police_data)
      expect(PoliceAlert.first.hundred_block_location).to eq("1XX BLOCK OF BROADWAY E")
    end
  end
end
