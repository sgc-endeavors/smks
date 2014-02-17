require 'spec_helper'

describe Image do
	
	it "has a valid factory" do
		FactoryGirl.create(:image).should be_valid
  end
	
	it { should belong_to(:user) }
	it { should belong_to(:story) }

end
