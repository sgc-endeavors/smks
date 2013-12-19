require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }
  subject { user }
  
  it { should have_many(:stories) }
  it { should have_many(:ratings) }
  it { should have_many(:comments) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }


  it { should_not allow_value(:false).for(:terms) }
  # NEED TO RESOLVE ISSUES W/ THE ABOVE TEST


  describe "User create" do
    let(:user) { FactoryGirl.create(:user, first_name: "Joe", last_name: "Smith", email: "joe_smith@gmail.com") }
    
    
    its(:first_name) { should == "Joe" }
    its(:last_name) { should == "Smith" }
    its(:email) { should == "joe_smith@gmail.com" }
    its(:password) { should == "iluvunicorns" }
    its(:is_admin) { should be_false }
    its(:terms) { should be_true }
  end
end



