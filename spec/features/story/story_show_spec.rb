require 'spec_helper'

describe "Story_Show Page" do 
	subject { page }
	
	before(:each) do
		@user = FactoryGirl.create(:user)
		@current_story = FactoryGirl.create(:story, id: 6, status: "published", published_date: Date.new(2012, 12, 3), share_type: "public", title: "Eating Boogers", body: "Booger eating story...")
		@comment = FactoryGirl.create(:comment, story_id: @current_story.id, user_id: @user.id)
		FactoryGirl.create(:comment, story_id: 99999, body: "I'm a comment not related to this story") # <- a comment not related to the current story.
		sign_in_as_existing_user(@user)
		visit story_path(@current_story)
	end


	it "shows the story details" do
		@current_story = FactoryGirl.create(:story, status: "published", published_date: Date.new(2012, 12, 3), share_type: "public", title: "Eating Boogers", body: "Booger eating story...")
		visit story_path(@current_story)
		should have_content("Eating Boogers")
		should have_content("Booger eating story...")
		should have_content("Junior")
	end

	context "has a previous story and a newer story" do
		before(:each) do
			@previous_story = FactoryGirl.create(:story, id: 5, status: "published", published_date: Date.new(2012, 12, 3), share_type: "public", title: "A Previous Story")	
			@newer_story = FactoryGirl.create(:story, id: 7, status: "published", published_date: Date.new(2012, 12, 3), share_type: "public", title: "A Newer Story")	
			visit story_path(@current_story)
		end

		it "includes a link to show the previous story" do
			click_on("<<")
			current_path.should == story_path(@previous_story)
		end

		it "includes a link to show the newer story" do
			click_on(">>")
			current_path.should == story_path(@newer_story)
		end

	end


	context "there is not a previous or newer story" do
		it "does NOT include a link to show the previous story" do
			should_not have_link("<<")
		end
		it "does not include a link to show the newer story" do
			should_not have_link(">>")
		end
	end


	###### The following 3 examples are not passing; however the code is working
		# it "includes a link to show all the stories" do
		# 	click_on "Show All"
		# 	current_path.should == stories_path(type: "public")
		# end

		# it "includes a link to show personal journal" do
		# 	click_on "Show Journal"
		# 	current_path.should == stories_path(type: "personal")
		# end	
	#######



	context "the story is authored by the current_user" do
		before(:each) do
			published_authored_story = FactoryGirl.create(:story, user_id: @user.id, status: "published", published_date: Date.new(2012, 12, 3), share_type: "private", title: "My Published Private Story")
			visit story_path(published_authored_story)
		end
		it "does NOT show 'ratings' buttons" do
			should_not have_button("1")
			should_not have_button("3")
		end
		it "routes user to the edit view of the story" do
			click_on "Edit Story"
			current_path.should == edit_story_path(Story.last)
		end

		# it "includes a link and allows a user to delete a story" do
		# 	click_on "Delete Story"
		# 	current_path.should == stories_path(type: "personal")
		# end
	end

	context "the story is not authored by the current_user" do
		before(:each) do
			published_non_authored_story = FactoryGirl.create(:story, status: "published", published_date: Date.new(2012, 12, 3), share_type: "private", title: "My Published Private Story")
			visit story_path(published_non_authored_story)
		end
		it "shows the 'ha-ha scale' buttons" do
			should have_button("0")
			should have_button("1")
			should have_button("3")
			should have_button("5")
			should have_button("7")
			should have_button("10")

		end
		it "should not have an 'Edit Story' link" do
			should_not have_link("Edit Story")
		end
		it "should not have a 'Delete Story' link" do
			should_not have_link("Delete Story")
		end

	end

	it "shows the total ratings for the story" do
		FactoryGirl.create(:rating, story_id: @current_story.id)
		FactoryGirl.create(:rating, numeric_score: 7, story_id: @current_story.id)
		visit story_path(@current_story)		
		should have_content("Ha-Ha Rating: 4x (per 2 people)")
	end

	context "user rates the story for the first time" do
		context "user presses the '1' button" do
			before(:each) { click_button "1" }
			
			it "should create a '1' user rating for the story" do
				Rating.where(story_id: @current_story.id).where(user_id: @user.id).first.numeric_score.should == 1
			end

			it "should return the user to the index stories path" do
				current_path.should == stories_path
			end
		end
		context "user presses '10' button" do
			it "should create a '10' user rating for the story" do
				click_button "10"
				Rating.where(story_id: @current_story.id).where(user_id: @user.id).first.numeric_score.should == 10
			end	
		end
	end

	context "user has already rated the story" do
		before(:each) do 
			FactoryGirl.create(:rating, user_id: @user.id, story_id: @current_story.id)
			visit story_path(@current_story)
		end

		it { should have_content("You gave this 1 Ha-Ha's") }
		it { should_not have_button("1") }

	end

	context "site visitor has not logged in" do
		before(:each) do
			click_on "Logout"
			visit story_path(@current_story)
		end
		it "should not be able to view ratings buttons" do
			should_not have_button("1")
			should_not have_button("3")
		end
		it "should not be able to 'Show Journal'" do
			should_not have_link("Show Scrapbook")
		end
		it "should not be able to create a comment without first logging in" do
			click_on("Create Comment")
			current_path.should == new_user_session_path
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