require 'spec_helper'

describe Kid do
 it { should belong_to(:user) }
 it { should have_many(:stories) }

	it "has a valid factory" do
		FactoryGirl.create(:kid).should be_valid
  end
end
