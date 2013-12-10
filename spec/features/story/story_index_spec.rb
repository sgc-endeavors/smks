require 'spec_helper'

describe "Story_Index Page" do

	before(:each) do
		@user = FactoryGirl.create(:user)
		2.times { FactoryGirl.create(:story, user_id: @user.id) }
	end

	subject { page }

	context "a user has logged in" do
		before(:each) { sign_in_as_existing_user(@user) }
		it "shows the page title" do
			within("h1") { should have_content("Stories Index") }
		end

		it "shows titles for multiple stories" do
			should have_content(Story.first.title)
			should have_content(Story.last.title)
		end

		it "includes a link to the stories 'show' page" do
			should have_link(Story.first.title)
		end

		it "shows the total ratings for the story" do
		@current_story = FactoryGirl.create(:story)
		FactoryGirl.create(:rating, story_id: @current_story.id)
		FactoryGirl.create(:rating, name: "thumbs down", story_id: @current_story.id)
		visit stories_path		
		should have_content("Thumbs Up: 1 | Thumbs Down: 1")
	end


		it "shows the first 300 characters of the story" do
			should have_content(Story.first.body[0..299])
		end

		it "allows user to access the story edit page" do 
			first(:link, "Edit Story").click
			current_path.should == edit_story_path(Story.first)
		end

		it "after deletion, redirects to root_path" do
			first(:link, "Delete").click
			current_path.should == root_path			
		end

		it "allows user to delete a selected story" do
			first(:link, "Delete").click
			Story.where(user_id: @user.id).count.should == 1			
		end

		it "allows user to access the create story page" do 
			click_on "Create"
			current_path.should == new_story_path
		end
	
		context "user is NOT an Administrator" do		
			it "shows the edit link for only those stories authored by the user" do
				FactoryGirl.create(:story) #
				should have_link("Edit Story", count: 2)
			end

			it "shows the delete link for only those stories authored by the user" do
				FactoryGirl.create(:story) #
				should have_link("Delete", count: 2)
			end

			it "should not be able to access the edit view via the URL unless you authored the story" do
				visit edit_story_path(FactoryGirl.create(:story)) #
				current_path.should == root_path
			end
		end
	end
	context "user is an Administrator" do		
		before(:each) { sign_in_as_existing_user(FactoryGirl.create(:user, is_admin: true)) } 

		it "shows the edit link for ALL stories" do
			should have_link("Edit Story", count: 2)
		end

		it "shows the delete link for ALL stories" do
			should have_link("Delete", count: 2)
		end

		it "should be able to access the edit view via the URL" do
			existing_story = FactoryGirl.create(:story)
			visit edit_story_path(existing_story) #
			current_path.should == edit_story_path(existing_story)
		end
	end	

	context "user has NOT logged in" do
		it "does NOT allow user to click on the edit link" do
			visit stories_path
			should_not have_link("Edit Story")
		end
	end




end


