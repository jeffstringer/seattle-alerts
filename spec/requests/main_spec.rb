require 'spec_helper'

describe 'Main' do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_content('911') }
    it { should have_title(full_title(page_title)) }
  end

  describe "Main page" do
    before { visit '/' }
    let(:page_title) { '' }

    it { should have_css('div#map') }

    it_should_behave_like "all static pages"
    it { should_not have_title('| Main') }
  end

  describe 'About page' do
    before { visit '/about' }
    let(:page_title) { 'About' }

    it_should_behave_like "all static pages"
    it { should have_content('Seattle Alerts') }
  end

  it "should have the right links on the layout" do
    visit '/'
    click_link "Seattle Alerts"
    expect(page).to have_title(full_title(''))
    click_link "About"
    expect(page).to have_title(full_title('About'))
  end
end
