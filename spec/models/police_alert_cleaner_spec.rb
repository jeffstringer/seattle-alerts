require 'spec_helper'

describe PoliceAlertCleaner do
  include DataSupport
  
  describe '.new' do
    let(:data) { raw_police_data.first }
    let(:alert) { PoliceAlertCleaner.new(data) }

    it 'creates an object from json' do 
      expect(alert.census_tract).to eq(data['census_tract'])
      expect(alert.event_clearance_date).to eq(data['event_clearance_date'])
      expect(alert.event_clearance_description).to eq(data['event_clearance_description'])
      expect(alert.general_offense_number).to eq(data['general_offense_number'])
      expect(alert.hundred_block_location).to eq(data['hundred_block_location'])
      expect(alert.latitude).to eq(data['latitude'])
      expect(alert.longitude).to eq(data['longitude'])
    end

    it 'does not include unused json attributes' do
      expect { alert.zone_beat }.to raise_error(NoMethodError)
    end
  end         
end