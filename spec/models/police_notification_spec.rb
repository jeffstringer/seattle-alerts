require 'spec_helper'

describe PoliceNotification do

  before do
    @subscriber = FactoryGirl.create(:subscriber)
    @subscriber.save
    @police_alert = FactoryGirl.create(:police_alert, created_at: Time.now)
  end

  describe "associations" do
    it { should belong_to(:subscriber) }
    it { should belong_to(:police_alert) }
  end

  context ".create_notifications" do  
    it "creates a notification when alert occurs within subscriber's radius" do
      expect(@subscriber.police_notifications).to be_empty
      PoliceNotification.create_notifications
      expect(@subscriber.distance_to([@police_alert.latitude, @police_alert.longitude])).to be < @subscriber.radius
      expect(@subscriber.police_notifications).to_not be_empty
    end

    it "does not create a notification when alert occurs outside radius" do
      @police_alert.update_attributes(latitude: 47.53154278, longitude: -122.279449045)
      expect(@subscriber.police_notifications).to be_empty
      expect(@subscriber.distance_to([@police_alert.latitude, @police_alert.longitude])).to be > @subscriber.radius
      expect(@subscriber.police_notifications).to be_empty
    end
  end
end