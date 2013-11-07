require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }
  subject { user }
  
  it "is invalid w/out an email address" do
    user.user_email = nil
    user.should_not be_valid
  end

  it "is invalid w/out agreeing to terms" do
    user.terms = false
    user.should_not be_valid
  end
  
  it "is invalid w/out a unique email address" do
    user1 = user
    user2 = FactoryGirl.build(:user)
    user2.should_not be_valid    
  end 
  
  its(:user_first) { should == "Joe" } 
  its(:user_last) { should == "Smith" }
  its(:user_email) { should == "joe_smith@gmail.com" }
  its(:password) { should == "iluvunicorns" }
  its(:is_admin) { should be_false }
  its(:terms) { should be_true }
end
