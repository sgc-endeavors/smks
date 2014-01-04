require 'spec_helper'

describe "Landing Page" do
	before(:each) { visit landing_page_path }
	subject { page }
	
	it {should have_link("Enter") }

	it "allow the user to visit the stories path" do
		click_on("Enter")
		current_path.should == stories_path
	end

	it "allow the user to visit the marketing content" do
		click_on("My Personal Journal")
		current_path.should == marketing_path
	end	

	it "allow the user to visit the marketing content" do
		click_on("Share Something Funny")
		current_path.should == marketing_path
	end	

	it "allow the user to visit the marketing content" do
		click_on("Read Something Funny")
		current_path.should == marketing_path
	end	


end
