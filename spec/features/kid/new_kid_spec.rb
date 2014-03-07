require 'spec_helper'

describe "Kid#New Page" do

		subject { page }


	let(:kid) { FactoryGirl.build(:kid, user_id: @user.id)}

	before(:each) do
		@user = FactoryGirl.create(:user)
		sign_in_as_existing_user(@user)
		visit new_kid_path
	end

	context "user fills in child information" do
		before(:each) do
			fill_in "Child's First Name", with: kid.name
			fill_in "birthdate", with: kid.birthdate
			click_on "Submit"
		end

		it "saves the child's name and birthdate" do			
			Kid.last.name.should == kid.name
			Kid.last.user_id.should == kid.user_id
			Kid.last.birthdate.should == kid.birthdate
		end

		it "routes the user back to the index" do
			current_path.should == kids_path
		end
	end

end