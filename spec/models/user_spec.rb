require 'spec_helper'

describe User do
  
  it "has a valid factory" do
    FactoryGirl.create(:user).should be_valid
  end
  
  it { should have_many(:stories) }
  it { should have_many(:ratings) }
  it { should have_many(:remarks) }
  it { should have_many(:people) }
  it { should have_many(:images) }
  it { should have_many(:friendships) }
  it { should have_many(:friends) }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }


  it { should_not allow_value(:false).for(:terms) }
  
end



