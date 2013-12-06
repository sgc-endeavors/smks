require 'spec_helper'

describe "Story_Index Page" do

	before(:each) do
		@user = FactoryGirl.create(:user)
		2.times { FactoryGirl.create(:story, user_id: @user.id) }
	end

	subject { page }

	context "user has logged in" do
		before(:each) { sign_in_as_existing_user(@user) }
		it "shows the page title" do
			within("h1") { should have_content("Stories Index") }
		end

		it "shows titles for multiple stories" do
			should have_content(Story.first.title)
			should have_content(Story.last.title)
		end

		it "shows the body of the story" do
			should have_content(Story.first.body)
		end
		
		

		it "allows user to access the story edit page" do 
			first(:link, "Edit Story").click
			current_path.should == edit_story_path(Story.first)
		end

		it "allows user to access the create story page" do 
			click_on "Create"
			current_path.should == new_story_path
		end
	
		it "shows the edit link for only those stories authored by the user" do
			FactoryGirl.create(:story)
			should have_link("Edit Story", count: 2)
		end

		it "should not be able to access the edit view via the URL unless you authored the story" do
			visit edit_story_path(FactoryGirl.create(:story))
			current_path.should == root_path
		end
	end

	context "user has NOT logged in" do
		it "does NOT allow user to click on the edit link" do
			visit stories_path
			should_not have_link("Edit Story")
		end
	end




end


