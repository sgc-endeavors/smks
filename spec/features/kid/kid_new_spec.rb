require 'spec_helper'

describe "Kid#New Page" do

	let(:new_kid) { FactoryGirl.build(:kid, user_id: @user.id)}

	before(:each) do
		@user = FactoryGirl.create(:user)
		sign_in_as_existing_user(@user)
		visit new_kid_path
	end

	it "saves the child's name" do
		fill_in "Child's First Name", with: new_kid.name
		click_on "Submit"
		Kid.last.name.should == new_kid.name
		Kid.last.user_id.should == new_kid.user_id

	end

end