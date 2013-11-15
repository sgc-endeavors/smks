require 'spec_helper'

describe Story do
  let(:story) { FactoryGirl.create(:story) }
  subject { story }

	it "has a valid factory" do
		FactoryGirl.create(:story).should be_valid
  end

  it "is invalid w/out 'title' " do
    story.title = nil
    should_not be_valid
  end

	it "is invalid w/out 'user_id'" do
    story.user_id = nil
    should_not be_valid
  end

  its(:title) { should == "Baby Gerard Craps His Pants at 1st Day of School" }
  its(:body) { should == "The body of the text" }
  its(:category_id) { should == 1 }
	its(:approved) { should == false }
	its(:picture_id) { should == 1 }
	its(:user_id) { should == 1 }
end
