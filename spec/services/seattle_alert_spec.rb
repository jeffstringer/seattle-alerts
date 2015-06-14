require 'spec_helper'

describe SeattleAlert do

  let(:subscriber) { Subscriber.find_by(email: "chairman@starbucks.com") }
  let(:police_alert) { PoliceAlert.find_by(general_offense_number: '2014396010') }
  let(:fire_alert) { FireAlert.find_by(incident_number: "F150013312") }
  let(:police_notification) { PoliceNotification.create(police_alert_id: police_alert.id, subscriber_id: subscriber.id) }
  let(:fire_notification) { FireNotification.create(fire_alert_id: fire_alert.id, subscriber_id: subscriber.id) }

  before { ActionMailer::Base.deliveries.clear }

  context "#call" do
    
    it "sends email upon alert within subscribers radius" do
      police_notification.update_attributes(created_at: 5.minutes.ago )
      fire_notification.update_attributes(created_at: 5.minutes.ago )
      SeattleAlert.call_notifications

      mail = ActionMailer::Base.deliveries.last
      body = mail.body.encoded

      expect(mail.subject).to eq("Activity Occurred in Your Area")
      expect(mail.to.first).to eq(subscriber.email)

      expect(body).to match(police_alert.hundred_block_location)
      expect(body).to match(police_alert.event_clearance_description.downcase.titleize)
      expect(body).to match(police_alert.event_clearance_date)

      expect(body).to match(fire_alert.address)
      expect(body).to match(fire_alert.fire_type)
      expect(body).to match(fire_alert.datetime)
    end
  end
end