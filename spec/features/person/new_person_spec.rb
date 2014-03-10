require 'spec_helper'

describe "Person#New Page" do

		subject { page }


	let(:person) { FactoryGirl.build(:person, user_id: @user.id)}

	before(:each) do
		@user = FactoryGirl.create(:user)
		sign_in_as_existing_user(@user)
		visit new_person_path
	end

	context "user fills in child information" do
		before(:each) do
			fill_in "Person's First Name", with: person.name
			fill_in "birthdate", with: person.birthdate
			click_on "Submit"
		end

		it "saves the child's name and birthdate" do			
			Person.last.name.should == person.name
			Person.last.user_id.should == person.user_id
			Person.last.birthdate.should == person.birthdate
		end

		it "routes the user back to the index" do
			current_path.should == people_path
		end
	end

end