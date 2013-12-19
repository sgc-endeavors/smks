require 'spec_helper'

describe "Story_New Page" do 
	subject { page }

	let(:new_story) { FactoryGirl.build(:story) }

	before(:each) do
		user = new_story.user
		sign_in_as_existing_user(user)
		visit new_story_path
	end

  it "saves the new story information upon submission" do
		submit_a_new_story(new_story)
 		last_story = Story.last
 		last_story.title.should == new_story.title
 		last_story.body.should == new_story.body
 		last_story.user_id.should == new_story.user_id		
  end

  it "shows the new story's page" do
  	submit_a_new_story(new_story)
 		current_path.should == story_path(Story.last)
  end
end




