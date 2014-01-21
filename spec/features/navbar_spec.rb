require 'spec_helper'

describe "Navbar Links" do
	
	before(:each) { visit stories_path(type: "public") }
	
	subject { page }

	context "visitor has or has not logged in" do
		it "has a link to 'Read Funny'" do
			should have_link("Read Funny")
			click_on("Read Funny")
			current_path.should == stories_path
		end
	end
	

	context "visitor has not logged in" do
		it "does NOT allow visitor to click on the My Personal Journal link" do
			should_not have_link("My Scrapbook")
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

		it "allows visitor to click on the My Personal Journal link" do
			should have_link("My Scrapbook")
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


		it "allows visitor to click on the Share Funny link" do
			should have_link("Share Funny")
			click_on("Share Funny")
			current_path.should == new_story_path
		end

	end
end				