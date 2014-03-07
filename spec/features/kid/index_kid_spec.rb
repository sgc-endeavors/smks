require 'spec_helper'

describe "Kid#Index Page" do


	subject { page }

	before(:each) do
		@user = FactoryGirl.create(:user)
		@kid = FactoryGirl.create(:kid, user_id: @user.id, name: "Adam")
	end

	context "visitor has not logged in" do
		before(:each) { visit kids_path }

		it "routes the user to the login page" do
			current_path.should == new_user_session_path
		end
	end

	context "visitor has logged in as a user" do	
		before(:each) do
			sign_in_as_existing_user(@user)
			visit kids_path
		end

		it { should have_content("Kids") }	
		it { should have_link("Add Kid")}
		it { should have_content("Adam") }
		it { should have_link("Edit") }
		context "user wants to add a kid" do
			it "routes the user to the new_kid_path" do
				click_on "Add Kid"
				current_path.should == new_kid_path
			end
		end

		context "user wants to edit a kid" do
			it "routes the user to the edit_kid_path" do
				click_on "Edit"
				current_path.should == edit_kid_path(@kid)
			end
		end
	end


end