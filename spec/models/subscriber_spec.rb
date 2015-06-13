require 'spec_helper'

describe Subscriber do

  let(:subscriber) { FactoryGirl.create(:subscriber) }

  describe "attributes" do
    it { is_expected.to respond_to(:email) }
    it { is_expected.to respond_to(:street) }
    it { is_expected.to respond_to(:latitude) }
    it { is_expected.to respond_to(:longitude) }
    it { is_expected.to respond_to(:password) }
    it { is_expected.to respond_to(:password_confirmation) }
    it { is_expected.to respond_to(:radius) }
    it { is_expected.to respond_to(:notify) }
  end

  describe "relationships" do
    it { is_expected.to have_many(:police_alerts) }
    it { is_expected.to have_many(:fire_alerts) }
  end

  context "email" do
    it "is invalid when email is not present" do
      expect(subscriber).to be_valid
      subscriber.email = " "
      expect(subscriber).to_not be_valid
    end

    it "is invalid with invalid email addresses" do
      expect(subscriber).to be_valid
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      addresses.each do |invalid_address|
        subscriber.email = invalid_address
        expect(subscriber).not_to be_valid
      end
    end

    it "is valid when email format is valid" do
      expect(subscriber).to be_valid
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        subscriber.email = valid_address
        expect(subscriber).to be_valid
      end
    end

    it "is invalid when email address is already taken" do
      expect(subscriber).to be_valid
      subscriber_with_same_email = subscriber.dup
      subscriber_with_same_email.email = subscriber.email.upcase
      subscriber_with_same_email.save
      expect(subscriber_with_same_email).to_not be_valid
    end
  end

  context "authentication" do
    it "is invalid when password is not present" do
      subscriber = Subscriber.create(email: "chairman@starbucks.com", street: "1912 Pike Pl",
                         password: " ", password_confirmation: " ", radius: 0.5)
      expect(subscriber).to_not be_valid
    end

    it "is invalid when password doesn't match confirmation" do
      expect(subscriber).to be_valid
      subscriber.password_confirmation = "mismatch"
      expect(subscriber).not_to be_valid
    end

    it "is invalid with a password that's too short" do
      expect(subscriber).to be_valid
      subscriber.password = subscriber.password_confirmation = "a" * 5
      expect(subscriber).not_to be_valid
    end

    let(:found_subscriber) { Subscriber.find_by(email: subscriber.email) }

    it "authenticates with a valid password" do
      subscriber.save
      expect(subscriber).to eq found_subscriber.authenticate(subscriber.password) 
    end

    it "does not authenticate with an invalid password" do
      subscriber_for_invalid_password = found_subscriber.authenticate("invalid")
      expect(subscriber).to_not eq subscriber_for_invalid_password
    end
  end

  context "geocoding" do 
    it "geocodes a latitude" do
      expect(subscriber).to be_valid
      expect(subscriber.latitude.to_s).to match(/47/)
    end

    it "geocodes a longitude" do
      expect(subscriber).to be_valid
      expect(subscriber.longitude.to_s).to match(/-122/)
    end
  end
end
