require 'spec_helper'

describe SeattleAlert do

  before do
    @subscriber = FactoryGirl.create(:subscriber)
    @police_alert = FactoryGirl.create(:police_alert)
    @fire_alert = FactoryGirl.create(:fire_alert)
    police_notification = PoliceNotification.create(police_alert_id: @police_alert.id, subscriber_id: @subscriber.id)
    fire_notification = FireNotification.create(fire_alert_id: @fire_alert.id, subscriber_id: @subscriber.id)
    police_notification.update_attributes(created_at: 5.minutes.ago )
    fire_notification.update_attributes(created_at: 5.minutes.ago )
    SeattleAlert.call_notifications
    @mail = ActionMailer::Base.deliveries.last
    @body = @mail.body.encoded
  end

  context "#call" do
    describe "sends email upon alert within subscribers radius" do
      it "renders headers" do
        expect(@mail.subject).to eq("Activity Occurred in Your Area")
        expect(@mail.to.first).to eq(@subscriber.email)
      end

      it "renders police_alert information in the email body" do
        expect(@body).to match(@police_alert.hundred_block_location)
        expect(@body).to match(@police_alert.event_clearance_description.downcase.titleize)
        expect(@body).to match(@police_alert.event_clearance_date)
      end

      it "renders fire_alert information in the email body" do
        expect(@body).to match(@fire_alert.address)
        expect(@body).to match(@fire_alert.fire_type)
        expect(@body).to match(@fire_alert.datetime)
      end
    end
  end
end