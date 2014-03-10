require 'spec_helper'

describe Person do
	
	it "has a valid factory" do
		FactoryGirl.create(:person).should be_valid
  end
	
	it { should belong_to(:user) }
	it { should have_many(:stories) }

end
