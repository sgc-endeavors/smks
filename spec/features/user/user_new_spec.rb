require 'spec_helper'

describe "User_New Page" do
	subject { page }
  let(:new_user) { FactoryGirl.build(:user)}

  before(:each) do
		visit new_user_registration_path
  end

	it "shows the page title" do
		within("h4") { should have_content("Create a New Account")}
	end

	it "saves the new users information upon submission" do
		sign_up_as_a_new_user(new_user)
		
		last_user = User.last
    last_user.first_name.should == new_user.first_name
    last_user.last_name.should == new_user.last_name
    last_user.email.should == new_user.email
    #last_user.terms.should == new_user.terms     #<  Resolve why this is not being properly passed and saved to the dbase.			
	end

	it "shows the story index page" do
		sign_up_as_a_new_user(new_user)
  	current_path.should == root_path
	end
end