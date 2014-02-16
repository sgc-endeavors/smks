require 'spec_helper'

describe Remark do
  subject(:remark) { FactoryGirl.create(:remark, body: "That is the cutest thing I've ever heard") }
  
	it "has a valid factory" do
		FactoryGirl.create(:remark).should be_valid
  end

 	it { should belong_to(:user) }
	it { should belong_to(:story) }
	  
end