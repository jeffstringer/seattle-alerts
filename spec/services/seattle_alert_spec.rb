require 'spec_helper'

describe SeattleAlert do

  let(:subscriber) { FactoryGirl.create(:subscriber) }
  let(:police_alert) { PoliceAlert.find_by(general_offense_number: '2014396010') }
  let(:fire_alert) { FireAlert.find_by(incident_number: "F150013312") }
  let(:police_notification) { PoliceNotification.create(police_alert_id: police_alert.id, subscriber_id: subscriber.id) }
  let(:fire_notification) { FireNotification.create(fire_alert_id: fire_alert.id, subscriber_id: subscriber.id) }

  context "#call" do
    
    it "sends email upon alert within subscribers radius" do
      ActionMailer::Base.deliveries.clear
      police_notification.update_attributes(created_at: 5.minutes.ago )
      fire_notification.update_attributes(created_at: 5.minutes.ago )
      SeattleAlert.call_notifications
      expect(ActionMailer::Base.deliveries.size).to eq(1)
    end
  end
end