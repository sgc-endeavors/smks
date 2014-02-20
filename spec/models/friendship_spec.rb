require 'spec_helper'

describe Friendship do
  it "has a valid factory" do
		FactoryGirl.create(:friendship).should be_valid
 	end

	it { should belong_to(:user) }
 	it { should belong_to(:friend) }

end
