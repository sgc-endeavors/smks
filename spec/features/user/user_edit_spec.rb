require 'spec_helper'

describe "User_Edit Page" do
    
  before(:each) do 
    @existing_user =  FactoryGirl.create(:user, first_name: "Joe", last_name: "Smith", email: "joe_smith@gmail.com")
    visit edit_user_path(@existing_user)  
  end
  
  subject { page }

  it "shows the page title" do
        within("h1") { should have_content("Edit Profile View") } 
  end

  it "displays the existing users information in the form" do
    should have_field("first_name", with: "Joe")
    should have_field("last_name", with: "Smith")
    should have_field("email", with: "joe_smith@gmail.com")
  end
 
  context "user presses update" do
    it "successfully saves the user information and routes them back to the show page" do
      update_existing_user_info
      click_on "Update"
      updated_user = User.find(@existing_user.id)
      updated_user.first_name.should == "Josey"
      updated_user.last_name.should == "Smiths"
      updated_user.email.should == "josey_smiths@gmail.com"
      current_path.should == user_path(@existing_user)
    end
  end

  context "users presses cancel" do
    it "does NOT save the user information and routes them back to the show page" do
      update_existing_user_info
      click_on "Cancel"
      updated_user = User.find(@existing_user.id)
      updated_user.first_name.should == "Joe"
      updated_user.last_name.should == "Smith"
      updated_user.email.should == "joe_smith@gmail.com"
      current_path.should == user_path(@existing_user)
    end

  end

end
