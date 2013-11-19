require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }
  subject { user }
  
  it "is invalid w/out an email address" do
    user.user_email = nil
    user.should_not be_valid
    #Calvin - build vs. create of factory especially if you have lots of tests can run a lot slower
    #Calvin - Shoulda gem (helps with validations & relationships)
  end

#Context - it is invalid w/o an email address, consider it
  it "is invalid w/out agreeing to terms" do
    user.terms = false
    user.should_not be_valid
  end
  
  it "is invalid w/out a unique email address" do
    user1 = user
    user2 = FactoryGirl.build(:user)
    user2.should_not be_valid    
  end 

  #Probably don't need this because you're testing Rails, we're not testing database here, would have to create a variable that pulls information from database 
  #  FactoryGirl.create(:user, :user_first => first_name).user_first should == first_name
  # Google "Magic Number Code Smell"
  describe "User create" do
    let(:user) { FactoryGirl.create(:user, :user_first => first_name, :user_last => last_name) }
    
    let(:first_name) { "Joe"}
    let(:last_name) { "Smith" }
    
    its(:user_first) { should == first_name }
    its(:user_last) { should == last_name }
    
    its(:user_email) { should == "joe_smith@gmail.com" }
    its(:password) { should == "iluvunicorns" }
    its(:is_admin) { should be_false }
    its(:terms) { should be_true }
  end
end



