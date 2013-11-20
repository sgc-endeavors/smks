require 'spec_helper'

describe "Story_Edit Page" do 
	subject { page }

	before(:each) do
		@current_story = FactoryGirl.create(:story, title: "Eating Boogers", body: "Booger eating story...")
		visit edit_story_path(@current_story)	
	end

	it "shows the page title" do
		within("h1") { should have_content("Story Edit View") }
	end

 	it "displays the existing story's information in the form" do
 		should have_field("title", with: "Eating Boogers")
 		should have_field("body", with: "Booger eating story...")

  end
 
  context "user presses update" do
    it "successfully saves the story information and routes them back to the show page" do
    	update_existing_story
    	click_on "Update"
    	updated_story = Story.last
    	updated_story.title.should == "Eating Burgers"
    	updated_story.body.should == "Burger eating story..."
    	current_path.should == story_path(updated_story)
    end
  
  end

  context "users presses cancel" do
    it "does NOT save the story information and routes them back to the show page" do
      update_existing_story
      click_on "Cancel"
      current_path.should == story_path(@current_story)
    end

  end












end