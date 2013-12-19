require 'spec_helper'

describe "Story_Show Page" do 
	subject { page }
	
	before(:each) do
		@user = FactoryGirl.create(:user)
		@current_story = FactoryGirl.create(:story, user_id: @user.id, title: "Eating Boogers", body: "Booger eating story...")
		@comment = FactoryGirl.create(:comment, story_id: @current_story.id, user_id: @user.id)
		FactoryGirl.create(:comment, story_id: 99999, body: "I'm a comment not related to this story") # <- a comment not related to the current story.
		sign_in_as_existing_user(@user)
		visit story_path(@current_story)
	end



	it "shows the story details" do
		should have_field("title", with: "Eating Boogers")
		should have_field("body", with: "Booger eating story...")
	end

	it "shows 'thumbs up/thumbs down' buttons" do
		should have_button("Thumbs Up")
		should have_button("Thumbs Down")
	end

	it "shows the total ratings for the story" do
		FactoryGirl.create(:rating, story_id: @current_story.id)
		FactoryGirl.create(:rating, name: "thumbs down", story_id: @current_story.id)
		visit story_path(@current_story)		
		should have_content("Thumbs Up: 1 | Thumbs Down: 1")
	end

	context "user rates the story for the first time" do
		context "user presses thumbs up button" do
			before(:each) { click_button "Thumbs Up" }
			
			it "should create a 'thumbs up' user rating for the story" do
				Rating.where(story_id: @current_story.id).where(user_id: @user.id).first.name.should == "thumbs up"
			end

			it "should return the user to the show path for the story" do
				current_path.should == story_path(@current_story)
			end
		end
		context "user presses thumbs down button" do
			it "should create a 'thumbs down' user rating for the story" do
				click_button "Thumbs Down"
				Rating.where(story_id: @current_story.id).where(user_id: @user.id).first.name.should == "thumbs down"
			end	
		end
	end

	context "user has already rated the story" do
		before(:each) do 
			FactoryGirl.create(:rating, user_id: @user.id, story_id: @current_story.id)
			visit story_path(@current_story)
		end

		it { should have_content("You scored this a thumbs up!") }
		it { should_not have_button("Thumbs Up") }

	end

	it "routes user to the edit view of the story" do
		click_on "Edit Story"
		current_path.should == edit_story_path(Story.last)
	end

	it "includes a link to show all the stories" do
		click_on "Show All"
		current_path.should == stories_path
	end

	it "should not be able to access the edit link unless you authored the story" do
			visit story_path(FactoryGirl.create(:story))
			should_not have_link("Edit Story")
	end

	context "site visitor has not logged in" do
		it "should not be able to view any links or buttons" do
			click_on "Logout"
			visit story_path(@current_story)
			should_not have_button("Thumbs Up")
			should_not have_button("Thumbs Down")
			
		end
	end



##### COMMENTS SECTION #####

	it "allows the user to access the comment/new view" do
		click_on("Create Comment")
		current_path.should == new_comment_path
	end

	it "includes a listing of all the comments for the story" do
		should have_content("That was the funniest thing I've ever read...")
		should_not have_content("I'm a comment not related to this story")
	end

	context "the current user authored the comment" do
		it { should have_link("Edit Comment") }
		it { should have_link("Delete") }
	
		it "routes the user to edit view when the user presses 'Edit'" do
			click_on("Edit Comment")
			current_path.should == edit_comment_path(@comment)
		end


	end

	context "the current user did not author the comment" do
		before(:each) do
			FactoryGirl.create(:comment, story_id: @current_story.id, user_id: 9999)
			visit story_path(@current_story)
		end

		it { should_not have_link("Edit Comment") }		
		it { should_not have_link("Delete") }


	end

end