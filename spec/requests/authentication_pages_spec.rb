require 'spec_helper'

describe 'Authentication' do

  subject { page }

  describe 'signin page' do
    before { visit signin_path }

    it { should have_content('Sign In') }
    it { should have_title('Sign In') }
  end

  describe 'signin' do
    before { visit signin_path }

    describe 'with invalid information' do
      before { click_button 'sign in' }

      it { should have_title('Sign In') }
      # it { should have_selector('div.alert.alert-error') }

      describe "after visiting another page" do
        before { click_link "Seattle Alerts" }
       # it { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe 'with valid information' do
        let(:subscriber) { FactoryGirl.create(:subscriber) }
        
        before do
          fill_in 'email',    with: subscriber.email.upcase
          fill_in 'password', with: subscriber.password
          click_button 'sign in'
        end

        it { should have_title(subscriber.email) }
        it { should have_link('Profile',     href: subscriber_path(subscriber)) }
        it { should have_link('Sign Out',    href: signout_path) }
        it { should_not have_link('Sign In', href: signin_path) }
        it { should_not have_link('Stay Informed', href: signin_path) }

      describe "followed by signout" do
        before { click_link "Sign Out" }
        it { should have_link('Sign In') }
      end
    end  
  end
end