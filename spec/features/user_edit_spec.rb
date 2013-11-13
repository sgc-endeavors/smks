require 'spec_helper'

describe "User_Edit Page" do
  
  existing_user =  FactoryGirl.create(:user)
    
  before(:each) { visit edit_user_path(existing_user) }
  subject { page }

  after(:all) { existing_user.destroy }
  #Note:  The above "after" call was done to empty our database 
  #after FactoryGirl creates (and saves) a new record for us to edit in
  #our test.  We are of the impression that Factory_Girl did this by default.
  #Is there an alternative.  As well, why does "after(:each) not work?"

  it "shows the page title" do
        within("h1") { should have_content("Edit Profile View") } 
  end

  it "displays the existing users information in the form" do
    should have_field("user_first", with: "Joe")
    should have_field("user_last", with: "Smith")
    should have_field("user_email", with: "joe_smith@gmail.com")
  end
  
  it "successfully saves the user information and routes them back to the show page" do
    update_existing_user_info
    updated_user = User.find(existing_user.id)
    updated_user.user_first.should == "Josey"
    updated_user.user_last.should == "Smiths"
    updated_user.user_email.should == "josey_smiths@gmail.com"
    current_path.should == user_path(existing_user)
  end






end
