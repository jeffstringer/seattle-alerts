require 'spec_helper'

describe Subscriber do

  before do
    @subscriber = Subscriber.new(email: "chairman@starbucks.com", street: "1912 Pike Pl", zipcode: "98101") 
  end

  subject { @subscriber }

  it { should respond_to(:email) }
  it { should respond_to(:street) }
  it { should respond_to(:zipcode) }

  it { should be_valid }

  describe "when email is not present" do
    before { @subscriber.email = " " }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
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

  describe "when street is not present" do
    before { @subscriber.street = " " }
    it { should_not be_valid }
  end

  describe "when zipcode is not present" do
    before { @subscriber.zipcode = " " }
    it { should_not be_valid }
  end
end
