require 'spec_helper'

describe "Friendship_Index Page" do 

	subject { page }	

	context "visitor visits friendship index page but has not logged in" do
	  it "routes the visitor to sign in " do
	    visit friendships_path
		  current_path.should == new_user_session_path
		end
	end

	context "visitor visits friendship index page AND has logged in as a user" do
		let(:user) { FactoryGirl.create(:user)}
		before(:each) do 
	    sign_in_as_existing_user(user)
	    @second_user = FactoryGirl.create(:user, first_name: "Fred", last_name: "Friend", email: "fredfriend@gmail.com")
	    visit friendships_path   
	  end

		it { should have_content("Find a Friend") }

	  describe "Friendship#Search Section" do
		 
		  it "has a search field for the user to find friends" do
		  	should have_field "search"
		  	should have_button "Search"
		  end

			context "user inputs 'Rob' in the search field and searches" do
				before(:each) do
					fill_in "search", with: "Fred"
					click_on "Search"
				end
				
				it { should have_content("fredfriend@gmail.com") }
				it { should have_link("Add as Friend") }
		
				context "user clicks 'Add as Friend'" do
					before(:each) { click_on "Add as Friend" }

					it "creates a new friendship w/ Fred" do
						Friendship.last.friend_id.should == @second_user.id
					end
					it 'routes user back to the friendship index view' do
						current_path.should == friendships_path
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
		
		describe "Friendship#List_of_Friends_Section" do
			it { should have_content "My Friends" }

			context "user has not yet added friends" do
				before(:each) { visit friendships_path }
				it { should have_content "You have not yet added any friends." }
			end

			context "user has friends" do
				before(:each) do
					FactoryGirl.create(:friendship, user_id: user.id, friend_id: @second_user.id)
					visit friendships_path
				end

				it "displays the list of people the user has 'friended'" do
					should have_content("Fred")
					should have_content("Friend")
					should have_link("Remove as Friend")
				end
				
				context "user wants to remove the friendship" do
					before(:each) { click_on "Remove as Friend" }
					it "removes the friendship" do
						current_path.should == friendships_path
						should_not have_content("Fred")
					end
				end


			end
		end

		describe "Friendship#List_of_Befriended_Section" do
			it { should have_content "Friended by" }

			context "user has not yet been befriended" do
				before(:each) { visit friendships_path }
				it { should have_content "You have not yet been added as a friend by anyone." }
			end

			context "user has been befriended by someone" do
				
				context "user has not yet decided to hide the friend's content" do
					before(:each) do
						FactoryGirl.create(:friendship, user_id: @second_user.id, friend_id: user.id)
						visit friendships_path
					end

					it "displays the list of people who have 'befriended' the user" do
						should have_content("Fred")
						should have_content("Friend")
					end
					
					it { should have_link ("Hide Their Content") }

					context "the user wishes to hide the friend's content" do
						it "now has a link to 'Show Their Content'" do
							click_on "Hide Their Content" 
							#should_not have_link "Hide Their Content"
							Friendship.where(user_id: @second_user.id).where(friend_id: user.id).first.hide_content.should == true
						end
					end
				end

				context "user has hidden the friend's content because they overshare" do
					before(:each) do
						FactoryGirl.create(:friendship, user_id: @second_user.id, friend_id: user.id, hide_content: true)
						visit friendships_path
					end
					it { should have_link("Show Their Content") }
				end			
			end

		end

	end
end

