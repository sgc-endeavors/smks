require 'spec_helper'

describe "User_Edit Page" do
  
  
    
  before(:each) do 
    @existing_user =  FactoryGirl.create(:user)
    visit edit_user_path(@existing_user)
    
  end
  
  subject { page }


  it "shows the page title" do
        within("h1") { should have_content("Edit Profile View") } 
  end

  it "displays the existing users information in the form" do
    should have_field("user_first", with: "Joe")
    should have_field("user_last", with: "Smith")
    should have_field("user_email", with: "joe_smith@gmail.com")
  end
  
  context "user presses update" do
    it "successfully saves the user information and routes them back to the show page" do
      update_existing_user_info
      click_on "Update"
      updated_user = User.find(@existing_user.id)
      updated_user.user_first.should == "Josey"
      updated_user.user_last.should == "Smiths"
      updated_user.user_email.should == "josey_smiths@gmail.com"
      current_path.should == user_path(@existing_user)
    end
  end

  context "users presses cancel" do
    it "does NOT save the user information and routes them back to the show page" do
      update_existing_user_info
      click_on "Cancel"
      updated_user = User.find(@existing_user.id)
      updated_user.user_first.should == "Joe"
      updated_user.user_last.should == "Smith"
      updated_user.user_email.should == "joe_smith@gmail.com"
      current_path.should == user_path(@existing_user)
    end

  end



end
