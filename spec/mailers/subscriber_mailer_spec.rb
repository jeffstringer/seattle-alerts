
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
end
