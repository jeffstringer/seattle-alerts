require 'spec_helper'

describe SubscriberMailer, :type => :mailer do

  let(:subscriber) { FactoryGirl.create(:subscriber) }
  let(:police_alert) { FactoryGirl.create(:police_alert, created_at: Time.now) }
  let(:fire_alert) { FactoryGirl.create(:fire_alert, created_at: Time.now) }
  let(:police_notification) { PoliceNotification.create(police_alert_id: police_alert.id, subscriber_id: subscriber.id, created_at: Time.now) }
  let(:fire_notification) { FireNotification.create(fire_alert_id: fire_alert.id, subscriber_id: subscriber.id, created_at: Time.now) }

  context "admin email upon signup" do

    let(:admin_mail) { SubscriberMailer.admin_email(subscriber) }

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

    let(:user_mail) { SubscriberMailer.signup_email(subscriber) }

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

    before do
      police_alert
      fire_alert
      police_notification
      fire_notification
    end

    let(:notification_mail) { SubscriberMailer.notification_email(subscriber.id) }
    
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
