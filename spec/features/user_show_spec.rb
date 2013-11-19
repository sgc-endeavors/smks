require 'spec_helper'

describe "User_Show Page" do
  subject { page }
  let(:new_user) { FactoryGirl.build(:user, first_name: "Joe", last_name: "Smith", email: "joe_smith@gmail.com")}

  before(:each) { sign_up_as_a_new_user(new_user) }

  it "shows the page title" do
  	  	within("h1") { should have_content("User Profile View") }	
	end

  it "shows the users profile" do
  	should have_field("first_name", with: "Joe")
  	should have_field("last_name", with: "Smith")
  	should have_field("email", with: "joe_smith@gmail.com")
  	#my_box = find("accept_terms")
  	#my_box.should be_checked
  	#has_checked_field("accept_terms")
  	# should have_field("accept_terms", with: "1")  << Still need to resolve how checkbox is handled.
	end

	it "includes a link to 'edit' the profile" do
  	click_on "Edit"
  	current_path.should == edit_user_path(User.last)
	end



end
