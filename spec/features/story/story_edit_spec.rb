require 'spec_helper'

describe "Story_Edit Page" do 
	subject { page }


  before(:each) do
    @user = FactoryGirl.create(:user)
		@current_story = FactoryGirl.create(:story, share_type: "public", user_id: @user.id, title: "Eating Boogers", body: "Booger eating story...")
		sign_in_as_existing_user(@user)
    visit edit_story_path(@current_story)	
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
      updated_story.share_type.should == "private"
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