require 'spec_helper'

describe "User_Index Page" do

	before(:each) do 
    @existing_users =  10.times { FactoryGirl.create(:multiple_user) }
    visit users_path   
  end
  
  subject { page }

  it "shows the page title" do
    within("h1") { should have_content("User Index") }
  end

  it "shows user information for multiple 'Joes'" do
		should have_content(User.first.user_first)
		should have_content(User.last.user_last)
		should have_content(User.first.user_email)
	end

	
	context "user presses the edit link" do

		it "has an 'Edit' link for each user" do
			first(:link, "Edit").click
			current_path.should == edit_user_path(User.first)
		end
	
	end

	context "user presses the delete link" do
		
		before(:each) do
			@destroyed_user = User.first.user_first
			first(:link, "Delete").click
		end

		it "has a 'delete' link which destroys the user" do 
			User.first.user_first.should_not == @destroyed_user
		end

		it "after destroy it returns the user to the index view" do
			current_path.should == users_path
		end

	end
 end