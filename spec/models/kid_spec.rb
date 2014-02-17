require 'spec_helper'

describe Kid do
	
	it "has a valid factory" do
		FactoryGirl.create(:kid).should be_valid
  end
	
	it { should belong_to(:user) }
	it { should have_many(:stories) }

end
