require 'spec_helper'

describe PoliceAlert do

  before { @police_alert = PoliceAlert.new(hundred_block_location: "2XX BLOCK OF VIRGINIA ST", event_clearance_description: "SUSPICIOUS PERSON", 
    event_clearance_date: "Sat Apr 12, 2014 at 02:01 PM", general_offense_number: "2014111970", census_tract: "8002.1001", latitude: 47.612065558, longitude: -122.341322531, 
    time_show: "2014-04-12 14:01:00") }

  subject { @police_alert }

  it { should respond_to(:hundred_block_location)}
  it { should respond_to(:event_clearance_description)}
  it { should respond_to(:event_clearance_date)}
  it { should respond_to(:general_offense_number)}
  it { should respond_to(:census_tract)}
  it { should respond_to(:latitude)}
  it { should respond_to(:longitude)}
  it { should respond_to(:time_show)}

  it { should be_valid }
    describe "when hundred_block_location is not present" do
      before { @police_alert.hundred_block_location = " " }
    it { should_not be_valid }
  end

  it { should be_valid }
    describe "when event_clearance_description is not present" do
      before { @police_alert.event_clearance_description = " " }
    it { should_not be_valid }
  end

  it { should be_valid }
    describe "when event_clearance_date is not present" do
      before { @police_alert.event_clearance_date = " " }
    it { should_not be_valid }
  end

  it { should be_valid }
    describe "when general_offense_number is not present" do
      before { @police_alert.general_offense_number = " " }
    it { should_not be_valid }
  end

  it { should be_valid }
    describe "when census_tract is not present" do
      before { @police_alert.census_tract = " " }
    it { should_not be_valid }
  end

  it { should be_valid }
    describe "when latitude is not present" do
      before { @police_alert.latitude = " " }
    it { should_not be_valid }
  end

  it { should be_valid }
    describe "when longitude is not present" do
      before { @police_alert.longitude = " " }
    it { should_not be_valid }
  end

  it { should be_valid }
    describe "when time_show is not present" do
      before { @police_alert.time_show = " " }
    it { should_not be_valid }
  end    

  describe "when police_alert already exists" do
    before do
      police_alert_with_same_general_offense_number = @police_alert.dup
      police_alert_with_same_general_offense_number.save
    end

    it { should_not be_valid }
  end
end
