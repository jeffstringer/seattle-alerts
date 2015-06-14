require 'spec_helper'

describe SubscriberMailer, :type => :mailer do

  let(:subscriber) { FactoryGirl.create(:subscriber) }
  let(:admin_mail) { SubscriberMailer.admin_email(subscriber) }
  let(:user_mail) { SubscriberMailer.signup_email(subscriber) }
  let(:police_alert) { PoliceAlert.find_by(general_offense_number: '2014396010') }
  let(:fire_alert) { FireAlert.find_by(incident_number: "F150013312") }
  let(:police_notification) { PoliceNotification.create(police_alert_id: police_alert.id, subscriber_id: subscriber.id) }
  let(:fire_notification) { FireNotification.create(fire_alert_id: fire_alert.id, subscriber_id: subscriber.id) }
  let(:notification_mail) { SubscriberMailer.notification_email([police_notification], [fire_notification], subscriber) }

  context "admin email upon signup" do
    it "renders the headers" do
      expect(admin_mail.subject).to eq("New Subscriber")
      expect(admin_mail.to).to eq(["jeff.j.stringer@gmail.com"])
      expect(admin_mail.from).to eq(["jeff.j.stringer@gmail.com"])
    end

    it "renders the body" do
      expect(admin_mail.body.encoded).to match(subscriber.email)
    end
  end

  context "user email upon signup" do
    it "renders the headers" do
      expect(user_mail.subject).to eq("Welcome to Seattle Alerts")
      expect(user_mail.to).to eq(["chairman@starbucks.com"])
      expect(user_mail.from).to eq(["jeff.j.stringer@gmail.com"])
    end

    it "renders the body" do
      expect(user_mail.body.encoded).to match(subscriber.email)
    end
  end

  context "user notification email when activity occurs" do
    it "renders the headers" do
      expect(notification_mail.subject).to eq("Activity Occurred in Your Area")
      expect(notification_mail.to).to eq(["chairman@starbucks.com"])
      expect(notification_mail.from).to eq(["jeff.j.stringer@gmail.com"])
    end

    it "renders the body" do
      expect(notification_mail.body.encoded).to match('Person With A Gun')
    end
  end
end
