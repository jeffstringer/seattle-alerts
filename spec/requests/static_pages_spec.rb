require 'spec_helper'

describe 'Static Pages' do

  describe "Main page" do
    before { visit root_path }

    it "should have the content 'Explore the map'" do
      expect(page).to have_content('Explore the map')
    end

    it 'shoud have the base title' do
      expect(page).to have_title('Seattle Alerts')
    end

     it "shoud have not have a custom page title 'Main'" do
      expect(page).not_to have_title('| Main')
    end

    it "should have a google map" do
      expect(page).to have_css('div#map_canvas')
    end  
  end

  describe 'About page' do
    before { visit about_path }

    it "should have the content 'Seattle Alerts'" do
      expect(page).to have_content('Seattle Alerts')
    end

    it 'shoud have the base title' do
      expect(page).to have_title('Seattle Alerts')
    end
  end

  describe 'Contact page' do
    before { visit contact_path }

    it "should have the content 'Contact us!'" do
      expect(page).to have_content('Contact us!')
    end

    it 'shoud have the base title' do
      expect(page).to have_title('Seattle Alerts')
    end
  end
end
