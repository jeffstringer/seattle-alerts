require 'spec_helper'

describe 'Authentication' do

  subject { page }

  describe 'signin page' do
    before { visit '/signin' }

    it { should have_content('Sign In') }
    it { should have_title('Sign In') }
  end

  describe 'signin' do
    before { visit '/signin' }

    describe 'with invalid information' do
      before { click_button 'sign in' }

      it { should have_title('Sign In') }

      describe "after visiting another page" do
        before { click_link "Seattle Alerts" }
      end
    end

    describe 'with valid information' do
      let(:subscriber) { FactoryGirl.create(:subscriber) }
        
      before do
        visit '/signin'
        fill_in 'email',    with: 'chairman@starbucks.com'
        fill_in 'password', with: 'coffee'
        click_button 'sign in'
        it { should have_link 'Sign Out' }
        click_link 'Sign Out'
        it { should have_button('sign In') }
      end
    end  
  end
end