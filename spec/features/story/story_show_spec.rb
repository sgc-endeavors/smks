require 'spec_helper'

describe "Story_Show Page" do 
	subject { page }
	
	before(:each) do
		@current_story = FactoryGirl.create(:story, title: "Eating Boogers", body: "Booger eating story...")
		sign_in_as_existing_user(FactoryGirl.create(:user))
		visit story_path(@current_story)
	end

	it "shows the page title" do
		within("h1") { should have_content("Story Summary") }
	end

	it "shows the story details" do
		should have_field("title", with: "Eating Boogers")
		should have_field("body", with: "Booger eating story...")
	end

	it "includes a link to 'edit' the story" do
		click_on "Edit"
		current_path.should == edit_story_path(Story.last)
	end

	it "includes a link to show all the stories" do
		click_on "Show All"
		current_path.should == stories_path
	end

end