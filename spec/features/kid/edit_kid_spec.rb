require 'spec_helper'

describe "Kid#Edit Page" do

	subject { page }

	let(:kid) { FactoryGirl.create(:kid, user_id: @user.id, name: "Steve") }

	before(:each) do
		@user = FactoryGirl.create(:user)
		sign_in_as_existing_user(@user)
		visit edit_kid_path(kid)
	end

	context "user saves updates to a kid" do
		before(:each) do
			fill_in "Child's First Name", with: "Stevie"
			fill_in "birthdate", with: kid.birthdate + 100.days
			click_on "Submit"
		end

		it "saves the updates" do
			Kid.last.name.should == "Stevie"
			Kid.last.birthdate.should == kid.birthdate + 100.days
		end

		it "routes the user back to the index" do
			current_path.should == kids_path
		end

	end
end