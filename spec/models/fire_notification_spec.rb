require 'spec_helper'

describe FireNotification do

  before do
    @subscriber = FactoryGirl.create(:subscriber)
    @subscriber.save
    @fire_alert = FactoryGirl.create(:fire_alert, created_at: Time.now)
  end

  describe "associations" do
    it { should belong_to(:subscriber) }
    it { should belong_to(:fire_alert) }
  end

  context ".create_notifications" do  
    it "creates a notification when alert occurs within subscriber's radius" do
      expect(@subscriber.fire_notifications).to be_empty
      FireNotification.create_notifications
      expect(@subscriber.distance_to([@fire_alert.latitude, @fire_alert.longitude])).to be < @subscriber.radius
      expect(@subscriber.fire_notifications).to_not be_empty
    end

    it "does not create a notification when alert occurs outside radius" do
      @fire_alert.update_attributes(latitude: 47.53154278, longitude: -122.279449045)
      expect(@subscriber.fire_notifications).to be_empty
      expect(@subscriber.distance_to([@fire_alert.latitude, @fire_alert.longitude])).to be > @subscriber.radius
      expect(@subscriber.fire_notifications).to be_empty
    end
  end
end