require 'spec_helper'

describe "Subscriber pages" do

  subject { page }

  describe "information page" do
    let(:subscriber) { FactoryGirl.create(:subscriber) }
    before { visit subscriber_path(subscriber) }

    it { should have_content(subscriber.email) }
    it { should have_title(subscriber.email) }
  end

  describe "stay informed page" do
    before { visit stayinformed_path }

    it { should have_content('Stay Informed') }
    it { should have_title(full_title('Stay Informed')) }
  end

  describe "Stay Informed" do

    before { visit stayinformed_path }

    let(:submit) { "Submit" }

    describe "with invalid information" do
      it "should not create a subscriber" do
        expect { click_button submit }.not_to change(Subscriber, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Email",                  with: "chairman@starbucks.com"
        fill_in "Street",                 with: "1912 Pike Pl"
        fill_in "Password",               with: "coffee", :match => :prefer_exact
        fill_in "Password Confirmation",  with: "coffee", :match => :prefer_exact
      end

      it "should create a subscriber" do
        expect { click_button submit }.to change(Subscriber, :count).by(1)
      end
    end
  end
end