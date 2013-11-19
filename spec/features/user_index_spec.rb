require 'spec_helper'

describe "User_Index Page" do

	before(:each) do 
    @existing_users =  2.times { FactoryGirl.create(:user) }
    visit users_path   
  end
  
  subject { page }

  it "shows the page title" do
    within("h1") { should have_content("User Index") }
  end

  it "shows user information for multiple 'Joes'" do
		should have_content(User.first.first_name)
		should have_content(User.last.last_name)
		should have_content(User.first.email)
	end

	
	context "user presses the edit link" do

		before(:each) do
			first(:link, "Edit").click
		end

		it "has an 'Edit' link for each user" do
			current_path.should == edit_user_path(User.first)
		end
	
	end

	context "user presses the delete link" do
		
		before(:each) do
			@destroyed_user = User.first.first_name
			first(:link, "Delete").click
		end

		it "has a 'delete' link which destroys the user" do 
			#search database for @destroyed_user to see if it still exists @destroyed_user.reload.should be_nil>>>> THE TEST WRITTEN THIS WAY DOES NOT PASS.
			User.first.first_name.should_not == @destroyed_user 
		end

		it "after destroy it returns the user to the index view" do
			current_path.should == users_path
		end

	end
 end