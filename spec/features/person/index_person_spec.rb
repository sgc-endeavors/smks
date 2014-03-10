require 'spec_helper'

describe "Person#Index Page" do


	subject { page }

	before(:each) do
		@user = FactoryGirl.create(:user)
		@person = FactoryGirl.create(:person, user_id: @user.id, name: "Adam")
	end

	context "visitor has not logged in" do
		before(:each) { visit people_path }

		it "routes the user to the login page" do
			current_path.should == new_user_session_path
		end
	end

	context "visitor has logged in as a user" do	
		before(:each) do
			sign_in_as_existing_user(@user)
			visit people_path
		end

		it { should have_content("Kids / Other People") }	
		it { should have_link("Add Person")}
		it { should have_content("Adam") }
		it { should have_link("Edit") }
		context "user wants to add a person" do
			it "routes the user to the new_person_path" do
				click_on "Add Person"
				current_path.should == new_person_path
			end
		end

		context "user wants to edit a person" do
			it "routes the user to the edit_person_path" do
				click_on "Edit"
				current_path.should == edit_person_path(@person)
			end
		end
	end


end