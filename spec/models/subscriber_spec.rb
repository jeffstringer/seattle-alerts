require 'spec_helper'

describe Subscriber do

  before(:all) do
    Geocoder.configure(:lookup => :test)

    Geocoder::Lookup::Test.add_stub(
    "1912 Pike Pl, Seattle, WA", [
    {
      'latitude'     => 47.6101798,
      'longitude'    => -122.3423919,
      'street'      => '1912 Pike Pl'
        }
      ]
    )
  end

  before do
    @subscriber = Subscriber.new(email: "chairman@starbucks.com", street: "1912 Pike Pl",
      latitude: 47.6101798, longitude: -122.3423919, password: "coffee", password_confirmation: "coffee", radius: 0.5)
  end

  subject { @subscriber }

  it { should respond_to(:email) }
  it { should respond_to(:street) }
  it { should respond_to(:latitude)}
  it { should respond_to(:longitude)}
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:radius) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

  #it { should have_many(:police_alerts) }
  #it { should have_many(:fire_alerts) }

  describe "when email is not present" do
    before { @subscriber.email = " " }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      addresses.each do |invalid_address|
        @subscriber.email = invalid_address
        expect(@subscriber).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @subscriber.email = valid_address
        expect(@subscriber).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      subscriber_with_same_email = @subscriber.dup
      subscriber_with_same_email.email = @subscriber.email.upcase
      subscriber_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @subscriber.email = mixed_case_email
      @subscriber.save
      expect(@subscriber.reload.email).to eq mixed_case_email.downcase
    end
  end

  describe "when street is not present" do
    before { @subscriber.street = " " }
    it { should_not be_valid }
  end

  describe "when password is not present" do
    before do
      @subscriber = Subscriber.new(email: "chairman@starbucks.com", street: "1912 Pike Pl",
                       password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @subscriber.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @subscriber.password = @subscriber.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @subscriber.save }
    let(:found_subscriber) { Subscriber.find_by(email: @subscriber.email) }

    describe "with valid password" do
      it { should eq found_subscriber.authenticate(@subscriber.password) }
    end

    describe "with invalid password" do
      let(:subscriber_for_invalid_password) { found_subscriber.authenticate("invalid") }

      it { should_not eq subscriber_for_invalid_password }
      specify { expect(subscriber_for_invalid_password).to be_false }
    end
  end

  describe "remember token" do
    before { @subscriber.save }
    its(:remember_token) { should_not be_blank }
  end
end
