require 'spec_helper'

describe Rating do
 it { should belong_to(:user) }
 it { should belong_to(:story) }

	it "has a valid factory" do
		FactoryGirl.create(:rating).should be_valid
  end

end
