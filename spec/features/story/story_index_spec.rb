require 'spec_helper'

describe "Story_Index Page" do

	before(:each) do
		2.times { FactoryGirl.create(:story) }
		visit stories_path		
	end

	subject { page }

	it "shows the page title" do
		within("h1") { should have_content("Stories Index") }
	end

	it "shows titles for multiple stories" do
		should have_content(Story.first.title)
		should have_content(Story.last.title)
	end

	it "allows user to access the story edit page" do 
		first(:link, "Edit").click
		current_path.should == edit_story_path(Story.first)
	end

	it "allows user to access the create story page" do 
		click_on "Create"
		current_path.should == new_story_path
	end


end


