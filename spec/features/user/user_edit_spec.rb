require 'spec_helper'

describe "User_Edit Page" do
	
	before(:each) do 
    @existing_user =  FactoryGirl.create(:user, first_name: "Joe", last_name: "Smith", email: "joe_smith@gmail.com")
    sign_in_as_existing_user(@existing_user)
    visit edit_user_registration_path  
  end

  subject { page }

  it "shows the page title" do
  	within ("h2") { should have_content("Edit User")}
  end

  it "displays the existing users information in the form" do
    should have_field("first_name", with: "Joe")
    should have_field("last_name", with: "Smith")
    should have_field("email", with: "joe_smith@gmail.com")
  end

  it "successfully saves the user information and routes them back to the story index page" do
    fill_in "first_name", with: "Josey"
		fill_in "last_name", with: "Smiths"
		fill_in "email", with: "josey_smiths@gmail.com"
		fill_in "current_password", with: "iluvunicorns"
    click_on "Update"
    
    updated_user = User.find(@existing_user.id)
    updated_user.first_name.should == "Josey"
    updated_user.last_name.should == "Smiths"
    updated_user.email.should == "josey_smiths@gmail.com"
    current_path.should == root_path
  end
end