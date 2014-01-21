require 'spec_helper'

describe "Story_Edit Page" do 
	subject { page }


  before(:each) do
    @user = FactoryGirl.create(:user)
		@published_story = FactoryGirl.create(:story, published_date: Date.new(2012, 12, 3), share_type: "public", user_id: @user.id, title: "Eating Boogers", body: "Booger eating story...")
    @unpublished_story = FactoryGirl.create(:story, share_type: "public", user_id: @user.id, title: "Eating Boogers", body: "Booger eating story...")

		@second_kid = FactoryGirl.create(:kid, name: "Jasmine", user_id: @user.id)
    sign_in_as_existing_user(@user)
    visit edit_story_path(@published_story)	
	end

 	it "displays the existing story's information in the form" do
 		should have_field("title", with: "Eating Boogers")
 		should have_field("body", with: "Booger eating story...")
    #should have_select(:kid_name, options: ["Junior"])
    #I'm not sure how to write this test for dropdown boxes.
  end
 
  context "user presses 'Publish'" do
    context "user has already published the story once before" do
      it "does not update the publish date" do
        update_existing_story
        click_on "Publish"
        updated_story = Story.find(@published_story)
        updated_story.published_date.should == @published_story.published_date
      end
    end


    it "successfully saves the story information and routes them back to the show page" do
    	update_existing_story
    	click_on "Publish"
    	updated_story = Story.find(@published_story.id)
    	updated_story.title.should == "Eating Burgers"
    	updated_story.body.should == "Burger eating story..."
      updated_story.share_type.should == "private"
      updated_story.kid.name.should == "Jasmine"
      updated_story.status.should == "published"
    	current_path.should == story_path(updated_story)
    end

  end

  context "user presses 'Save as Draft'" do
    it "successfully saves the story information and routes them back to the show page" do
    visit edit_story_path(@unpublished_story) 

      update_existing_story
      click_on "Save as Draft"
      updated_story = Story.find(@unpublished_story)
      updated_story.title.should == "Eating Burgers"
      updated_story.body.should == "Burger eating story..."
      updated_story.kid.name.should == "Jasmine"
      updated_story.share_type.should == "private"
      updated_story.status.should == "draft"
      updated_story.published_date.should be_nil
      current_path.should == story_path(updated_story)
    end
  end

  context "users presses cancel" do
    it "does NOT save the story information and routes them back to the show page" do
      update_existing_story
      click_on "Cancel"
      current_path.should == story_path(@published_story)
    end

  end












end