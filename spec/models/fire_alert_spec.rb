require 'spec_helper'

describe FireAlert do

before { @fire_alert = FireAlert.new(address: "823 Madison St", datetime: "Sat Apr  5, 2014 at 04:23 PM", 
  incident_number: "F140034051", latitude: 47.608054, longitude: -122.32821, fire_type: "Auto Fire Alarm") }

  subject { @fire_alert }

  it { should respond_to(:address)}
  it { should respond_to(:datetime)}
  it { should respond_to(:incident_number)}
  it { should respond_to(:fire_type)}
  it { should respond_to(:latitude)}
  it { should respond_to(:longitude)}

  it { should be_valid }
    describe "when address is not present" do
      before { @fire_alert.address = " " }
    it { should_not be_valid }
  end

  it { should be_valid }
    describe "when datetime is not present" do
      before { @fire_alert.datetime = " " }
    it { should_not be_valid }
  end

  it { should be_valid }
    describe "when incident_number is not present" do
      before { @fire_alert.incident_number = " " }
    it { should_not be_valid }
  end

  it { should be_valid }
    describe "when fire_type is not present" do
      before { @fire_alert.fire_type = " " }
    it { should_not be_valid }
  end

  it { should be_valid }
    describe "when latitude is not present" do
      before { @fire_alert.latitude = " " }
    it { should_not be_valid }
  end

   it { should be_valid }
    describe "when longitude is not present" do
      before { @fire_alert.longitude = " " }
    it { should_not be_valid }
  end
end
