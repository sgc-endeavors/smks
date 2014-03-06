require 'spec_helper'

describe "Home Page" do
	subject { page }

	before(:each) { visit home_path }

	it {should have_link("Enter") }

	context "visitor has or has not logged in" do
		it "allow the user to visit the marketing content" do
			click_on("My Journal")
			current_path.should == marketing_path
		end	

		it "allow the user to visit the marketing content" do
			click_on("Share Something Funny")
			current_path.should == marketing_path
		end	

		it "allow the user to visit the marketing content" do
			click_on("Read Something Funny")
			current_path.should == marketing_path
		end	
	end

	context "visitor has NOT logged in" do
		it "allow the user to visit the stories path" do
			click_on("Enter")
			current_path.should == stories_path
		end
	end
	
	context "visitor has logged in" do
		
		context "user has set their default view preference to show their stories and their friends stories" do
			before(:each) do 
				@user = FactoryGirl.create(:user, default_view_preference: "My Friends")
				sign_in_as_existing_user(@user)
			end
			it "routes the user to the story index view for shared stories" do
				click_on "Enter"
				should have_content("Me & My Friends' Shared Stories")
			end
		end
		context "user has set their default view preference to show the public stories " do
			before(:each) do 
				@user = FactoryGirl.create(:user, default_view_preference: "Public")
				sign_in_as_existing_user(@user)
			end
			it "routes the user to the story index view for all public stories" do
				click_on "Enter"
				should have_content("Share with Everyone")
			end
		end
		context "user has set their default view preference to show only their own stories " do
			before(:each) do 
				@user = FactoryGirl.create(:user, default_view_preference: "My Stories")
				sign_in_as_existing_user(@user)
			end
			it "routes the user to the story index view for their own stories only" do
				click_on "Enter"
				should have_content("All of My Stories")
			end
		end


	end

end
