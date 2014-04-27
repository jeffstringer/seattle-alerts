require 'spec_helper'

describe Contact do
  
  #describe 'Contact page' do
  #  before { visit contacts_new_path }
  #  let(:page_title) { 'Contact' }
    
  #  it { should have_content('Contact us!') }
  #end

  before do
    @contact = Contact.new(email: "user@example.com", comment: "Great job!  Do you have plans for other cities, too?") 
  end  

  subject { @contact }

  it { should respond_to(:email) }
  it { should respond_to(:comment) }

  it { should be_valid }

  describe "when email is not present" do
    before { @contact.email = " " }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      addresses.each do |invalid_address|
        @contact.email = invalid_address
        expect(@contact).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @contact.email = valid_address
        expect(@contact).to be_valid
      end
    end
  end

  describe "when comment is not present" do
    before { @contact.comment = " " }
    it { should_not be_valid }
  end
end
