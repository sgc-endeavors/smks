require 'spec_helper'

describe Story do
  let(:story) { FactoryGirl.create(:story, title: "Baby Gerard Craps His Pants", user_id: 1) }
  subject { story }

	it "has a valid factory" do
		FactoryGirl.create(:story).should be_valid
  end

  it { should belong_to(:user) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:user_id) }
	  
  its(:title) { should == "Baby Gerard Craps His Pants" }
  its(:body) { should == "The body of the text" }
  its(:category_id) { should == 1 }
	its(:approved) { should == false }
	its(:picture_id) { should == 1 }
	its(:user_id) { should == 1 }

end