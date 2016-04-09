require 'spec_helper'

describe FireAlertCleaner do
  include DataSupport
  
  describe '.new' do
    let(:data) { raw_fire_data.first }
    let(:alert) { FireAlertCleaner.new(data) }

    it 'creates an object from json' do 
      expect(alert.address).to eq(data['address'])
      expect(alert.incident_number).to eq(data['incident_number'])
      expect(alert.latitude).to eq(data['latitude'])
      expect(alert.longitude).to eq(data['longitude'])
      expect(alert.type).to eq(data['type'])
    end

    it 'does not include unused json attributes' do
      expect { alert.report_location }.to raise_error(NoMethodError)
    end
  end         
end