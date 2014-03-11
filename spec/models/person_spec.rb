require 'spec_helper'

describe Person do
	
	it "has a valid factory" do
		FactoryGirl.create(:person).should be_valid
  end
	
	it { should belong_to(:user) }
	it { should have_many(:stories) }

	#CREATE NEW PERSON - creates a new person for the drop down list of people you can attribute a story to using the person who signed up first's name.
	it { Person.should respond_to(:create_new_person_at_registration) }

	describe "#create_new_person_at_registration" do
		it "creates a new user based on the registerants name and email" do
			new_user = FactoryGirl.create(:user, first_name: "Angus", email: "ayoung@gmail.com" )
			Person.create_new_person_at_registration(new_user)
			Person.last.name.should == "Angus"
			Person.last.user_id.should == new_user.id
		end

	end

end
