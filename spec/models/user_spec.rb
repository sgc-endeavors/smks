require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }
  subject { user }
  
  it "is invalid w/out an email address" do
    user.email = nil
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

  
  describe "User create" do
    let(:user) { FactoryGirl.create(:user, first_name: "Joe", last_name: "Smith") }
    
    
    its(:first_name) { should == "Joe" }
    its(:last_name) { should == "Smith" }
    its(:email) { should == "joe_smith@gmail.com" }
    its(:password) { should == "iluvunicorns" }
    its(:is_admin) { should be_false }
    its(:terms) { should be_true }
  end
end



