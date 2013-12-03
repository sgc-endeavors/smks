require 'spec_helper'

describe "Story_New Page" do 
	subject { page }

	let(:new_story) { FactoryGirl.build(:story) }

	before(:each) do
		visit new_story_path
	end

	it "includes a page title" do  
 		within("h1") { should have_content("Create Story") }
  end

  it "saves the new story information upon submission" do
		submit_a_new_story(new_story)
 		last_story = Story.last
 		last_story.title.should == new_story.title
 		last_story.body.should == new_story.body
 		
  end

  it "shows the new story's page" do
  	submit_a_new_story(new_story)
 		current_path.should == story_path(Story.last)
  end




	


end




