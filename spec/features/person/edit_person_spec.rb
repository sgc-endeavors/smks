require 'spec_helper'

describe "Person#Edit Page" do

	subject { page }

	let(:person) { FactoryGirl.create(:person, user_id: @user.id, name: "Steve") }

	before(:each) do
		@user = FactoryGirl.create(:user)
		sign_in_as_existing_user(@user)
		visit edit_person_path(person)
	end

	context "user saves updates to a person" do
		before(:each) do
			fill_in "Person's First Name", with: "Stevie"
			fill_in "birthdate", with: person.birthdate + 100.days
			click_on "Submit"
		end

		it "saves the updates" do
			Person.last.name.should == "Stevie"
			Person.last.birthdate.should == person.birthdate + 100.days
		end

		it "routes the user back to the index" do
			current_path.should == people_path
		end

	end
end