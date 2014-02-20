require 'spec_helper'

describe "User_Index Page" do

	before(:each) do 
    @user = FactoryGirl.create(:user)
    @second_user = FactoryGirl.create(:user, email: "robsmith11@gmail.com")
    visit users_path   
  end
  
  subject { page }

  it "routes the visitor to sign in if they haven't already done so" do
  	current_path.should == new_user_session_path
  end

  context "user has signed in" do
  	before(:each) do
  		sign_in_as_existing_user(@user)
  		visit users_path
  	end
	  it "shows the page title" do
	    within("h1") { should have_content("Find a Friend") }
	  end
	 
	  it "has a search field for the user to find friends" do
	  	should have_field "search"
	  	should have_button "Search"
	  end

		context "user inputs 'Rob' in the search field and searches" do
			before(:each) do
				fill_in "search", with: "Rob"
				click_on "Search"
			end
			
			it { should have_content("robsmith11@gmail.com") }
			it { should have_link("Add as Friend") }
	
			context "user clicks 'Add as Friend'" do
				before(:each) { click_on "Add as Friend" }

				it "creates a new friendship w/ Rob" do
					Friendship.last.friend_id.should == @second_user.id
				end
				it 'routes user back to the user index view' do
					current_path.should == users_path
				end
			end


	  end












	  context "user inputs 'Larry' in the search field and searches" do
			it "returns 'No user's found with that name. Search again.'" do
				fill_in "search", with: "Larry"
				click_on "Search"
				should have_content("No user's found with that name. Search again.")
			end
	  end


	end
 end