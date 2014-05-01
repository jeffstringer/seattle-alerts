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

    let(:submit) { "receive alerts" }

    describe "with invalid information" do
      it "should not create a subscriber" do
        expect { click_button submit }.not_to change(Subscriber, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "email",                  with: "chairman@starbucks.com"
        fill_in "street",                 with: "1912 Pike Pl"
        fill_in "password",               with: "coffee", :match => :first
        fill_in "confirmation",           with: "coffee", :match => :first
      end

      it "should create a subscriber" do
        expect { click_button submit }.to change(Subscriber, :count).by(1)
      end

      describe "after saving the subscriber" do
        before { click_button submit }
        let(:subscriber) { Subscriber.find_by(email: 'chairman@starbucks.com') }

        it { should have_link('Sign Out') }
        it { should have_title(subscriber.email) }
        #it { should have_selector('div.alert.alert-success', text: 'Thank you') }
      end
    end
  end
end
