require 'spec_helper'

describe "Landing Page" do
	before(:each) { visit root_path }
	subject { page }
	
	it {should have_link("Enter") }

	it "allow the user to visit the stories path" do
		click_on("Enter")
		current_path.should == stories_path
	end


end
