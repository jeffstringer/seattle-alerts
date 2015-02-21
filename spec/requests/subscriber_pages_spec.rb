require 'spec_helper'
require 'launchy'

describe "Subscriber pages" do

  subject { page }

  describe "stay informed page" do
    before { visit '/stayinformed' }

    it { should have_content('Stay Informed') }
    it { should have_title(full_title('Stay Informed')) }
  end

  describe "Stay Informed" do

    before { visit '/stayinformed' }

    let(:submit) { "receive alerts" }

    describe "with invalid information" do
      it "should not create a subscriber" do
        expect { click_button submit }.not_to change(Subscriber, :count)
      end
    end

    describe "with valid information" do
      before do
        subscriber = FactoryGirl.create(:subscriber)
      end

      it "should create a subscriber" do
        expect(Subscriber.find_by(email: "chairman@starbucks.com")).to_not eq(nil)
      end
    end
  end
end
