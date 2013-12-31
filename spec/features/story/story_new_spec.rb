require 'spec_helper'

describe "Story_New Page" do 
	subject { page }

	let(:new_story) { FactoryGirl.build(:story) }

	before(:each) do
		user = new_story.user
		sign_in_as_existing_user(user)
		visit new_story_path
	end

	it "defaults to the user's share preference unless it is overwrittern" do
		#by default, a FactoryGirl user has a default share preference of "public"
		# the submit_a_new_story helper method does not set the "share_type" for a new story.
		submit_a_new_story(new_story)
 		last_story = Story.last
 		last_story.title.should == new_story.title
 		last_story.body.should == new_story.body
 		last_story.share_type.should == 'public'
 		last_story.user_id.should == new_story.user_id		
  end

  context "user wants to submit a new story" do
	  before(:each) { submit_a_new_story(new_story) }
	  it "saves the new story information upon submission" do
	 		last_story = Story.last
	 		last_story.title.should == new_story.title
	 		last_story.body.should == new_story.body
	 		last_story.share_type.should == new_story.share_type
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
	 		last_story.share_type.should == new_story.share_type
	 		last_story.user_id.should == new_story.user_id	
	 		last_story.status.should == "draft"		
	  end
	  it "shows the new story's page" do
	 		current_path.should == story_path(Story.last)
	  end
	end

  it "routes the user back to the stories_path upon cancel" do
	  	click_on "Cancel"
	  	current_path.should == stories_path
	  end

end




