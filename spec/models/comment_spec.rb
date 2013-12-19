require 'spec_helper'

describe Comment do
  subject(:comment) { FactoryGirl.create(:comment, body: "That is the cutest thing I've ever heard") }
  
	it "has a valid factory" do
		FactoryGirl.create(:comment).should be_valid
  end

 	it { should belong_to(:user) }
	it { should belong_to(:story) }
	  
end