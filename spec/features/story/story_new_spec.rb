require 'spec_helper'

describe "Story_New Page" do 
	let(:new_story) { FactoryGirl.build(:story, user_id: user.id, kid_id: @kid.id) }
	let(:user) { FactoryGirl.create(:user, default_share_preference: "private") }
	before(:each) do
		@kid = FactoryGirl.create(:kid, user_id: user.id)
		sign_in_as_existing_user(user)
		visit stories_path
	end

	subject { page }

	context "user visits the new story page via the 'Share Funny' link" do
		before(:each) { click_on "Share Funny" }

		it "defaults stories 'share type' to 'public'" do
			submit_a_new_story(new_story)
			last_story = Story.last
 		 	last_story.share_type.should == 'public'
		end


	end

	context "user visits the new story page via the 'Create' link" do
		before(:each) { click_on "Create" }
		
		it "defaults to the user's share preference unless it is overwrittern" do
			submit_a_new_story(new_story)
			last_story = Story.last
 		 	last_story.share_type.should == 'private'
		end
	end

	context "user visits the new story page EITHER WAY" do
		before(:each) { visit new_story_path }		

	  context "user wants to assign a child's name to the story" do
	  	before(:each) do
	  		click_on "Add Child"
	  	end
	  	it "should route to the new kids path" do
	  		current_path.should == new_kid_path
	  	end
	  end






	  context "user wants to submit a new story" do
		  before(:each) { submit_a_new_story(new_story) }

		  it "saves the new story information upon submission" do
		 		last_story = Story.last
		 		last_story.title.should == new_story.title
		 		last_story.body.should == new_story.body
		 		last_story.share_type.should == "private"
		 		last_story.kid.name.should == "Junior"
		 		last_story.user_id.should == new_story.user_id	
		 		last_story.status.should == "published"		
		  end
		  it "shows the new story's page" do
		 		current_path.should == story_path(Story.last)
		  end
		end
	
		context "user wants to save the new story as a draft for the time being" do
		  before(:each) { save_draft_of_a_new_story(new_story) }
		  it "saves the new story information upon submission" do
		 		last_story = Story.last
		 		last_story.title.should == new_story.title
		 		last_story.body.should == new_story.body
		 		last_story.share_type.should == "private"
		 		last_story.user_id.should == new_story.user_id	
		 		last_story.status.should == "draft"		
		  end
		  it "shows the new story's page" do
		 		current_path.should == story_path(Story.last)
		  end
		end

		context "user wants to save the new story as a draft for the time being" do
		  before(:each) { click_on "Cancel" }

	  	it "routes the user back to the stories_path upon cancel" do
		  	current_path.should == stories_path
			end
		end
	end
end




