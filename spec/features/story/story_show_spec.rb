require 'spec_helper'

describe "Story_Show Page" do 
	subject { page }
	
	before(:each) do
		@user = FactoryGirl.create(:user)
		@current_story = FactoryGirl.create(:story, user_id: @user.id, title: "Eating Boogers", body: "Booger eating story...")
		sign_in_as_existing_user(@user)
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

	it "should include radio buttons for funny, not_funny, no_score" do
		should have_field("funny")
	end
	it "should not be able to access the show view via the URL unless you authored the story" do
			visit story_path(FactoryGirl.create(:story))
			current_path.should == root_path
	end


end