require 'spec_helper'

describe "Navbar Links" do
	
	before(:each) { visit stories_path(type: "public") }
	
	subject { page }

	context "visitor has or has not logged in" do
		it "has a link to 'Public'" do
			should have_link("Public")
			click_on("Public")
			current_path.should == stories_path
		end
	end
	

	context "visitor has not logged in" do
		it "does NOT allow visitor to click on the My Personal Journal link" do
			should_not have_link("My Journal")
		end

		it "allows visitor to click on the Complete Drafts link" do
			should_not have_link("Finish Drafts")
		end



	end

	context "visitor has logged in" do
		before(:each) do
			@user = FactoryGirl.create(:user)
			sign_in_as_existing_user(@user)
			visit stories_path(type: "public")
		end

		it "allows visitor to click on the 'My Stories' link" do
			should have_link("My Stories")
		end

		context "user has unfinished drafts" do
			before(:each) do 
				FactoryGirl.create(:story, user_id: @user.id, status: "draft")
				visit stories_path
			end
			it "allows visitor to click on the Complete Drafts link" do
				should have_link("Finish Drafts")
			end
		end

		context "user has NO ufinished drafts" do
			
			it "does NOT allow visitor to click on the Complete Drafts link" do
				should_not have_link("Finish Drafts")
			end
		end


		it "allows visitor to click on the Create New link" do
			should have_link("Create New")
			click_on("Create New")
			current_path.should == new_story_path
		end

	end
end				