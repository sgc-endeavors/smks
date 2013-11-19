require 'spec_helper'

#Global testing questions: is it helping me code right now (2) can somebody break this
#Flow of testing >> 1) start with feature spec 2) 
describe "User_Create Page" do
  subject { page }
  let(:new_user) { FactoryGirl.build(:user)}

  before(:each) do
    visit new_user_path
    
  end 

  it "includes a page title" do  
    within("h1") do
      should have_content("SMKS")
    end
    #get rid of this b/c its redundant from line 8
    current_path.should == new_user_path
  end

  it "saves the new users information upon submission" do
    sign_up_as_a_new_user(new_user)
    #create last_user = User.last so you don't have to load database every time
    User.last.user_first.should == new_user.user_first
    User.last.user_last.should == new_user.user_last
    User.last.user_email.should == new_user.user_email
    #User.last.terms.should == new_user.terms     #<  Resolve why this is not being properly passed and saved to the dbase.
  end

  it "shows the new users profile page" do
    sign_up_as_a_new_user(new_user)
    current_path.should == user_path(User.last)
  end

end



