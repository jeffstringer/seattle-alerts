
RSpec.describe SubscriberMailer, :type => :mailer do
  describe "email sent to user when user signs up" do
    let(:subscriber) { FactoryGirl.create(:subscriber) }
    let(:mail) { SubscriberMailer.signup_email(subscriber) }

    it "renders the headers" do
      expect(mail.subject).to eq("Welcome to Seattle Alerts")
      expect(mail.to).to eq(["chairman@starbucks.com"])
      expect(mail.from).to eq(["jeff.j.stringer@gmail.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(subscriber.email)
    end
  end

  describe "email sent to user when activity occurrs" do
    Subscriber.all.each {|s| s.destroy }
    subscriber2 = FactoryGirl.create(:subscriber2)
    PoliceAlert.all.each {|p| p.destroy }
    police_alert = FactoryGirl.create(:police_alert)
    FireAlert.all.each {|f| f.destroy }
    fire_alert = FactoryGirl.create(:fire_alert)
    PoliceNotification.all.each {|p| p.destroy }
    police_notification = PoliceNotification.create(police_alert_id: police_alert.id, subscriber_id: subscriber2.id)
    FireNotification.all.each {|f| f.destroy }
    fire_notification = FireNotification.create(fire_alert_id: fire_alert.id, subscriber_id: subscriber2.id)
    let(:mail) { SubscriberMailer.notification_email([police_notification], [fire_notification], subscriber2) }

    it "renders the headers" do
      expect(mail.subject).to eq("Activity Occurred in Your Area")
      expect(mail.to).to eq(["taster@starbucks.com"])
      expect(mail.from).to eq(["jeff.j.stringer@gmail.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match('Person With A Gun')
    end
  end
end
