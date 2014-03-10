require 'spec_helper'

describe Story do
 
	it "has a valid factory" do
		FactoryGirl.create(:story).should be_valid
  end

  it { should belong_to(:user) }
  it { should have_many(:ratings) }
  it { should have_many(:remarks) }
  it { should belong_to(:person) }
  it { should have_many(:images) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:user_id) }
	  
end
