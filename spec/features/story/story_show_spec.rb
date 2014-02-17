require 'spec_helper'

describe "Story_Show Page" do 
	subject { page }
	
	before(:each) do
		@user = FactoryGirl.create(:user)
		@current_public_published_story = FactoryGirl.create(:story, user_id: @user.id, id: 6, title: "Current Publich Published Story", status: "published", published_date: Date.new(2012, 12, 6), share_type: "public", title: "Eating Boogers", body: "Booger eating story...")
	end
	
	context "site visitor has not logged in" do
		before(:each) { visit story_path(@current_public_published_story) }
		
		it "should not be able to view ratings buttons" do
			should_not have_button("1")
			should_not have_button("3")
		end
		it "should not be able to see 'Show Scrapbook'" do
			should_not have_link("Show Scrapbook")
		end
		it "should not be able to create a remark without first logging in" do
			click_on("Create Remark")
			current_path.should == new_user_session_path
		end
	end

	context "visitor signs in as a user" do
		before(:each) { sign_in_as_existing_user(@user) }
		
		describe "Show_page_content" do
			before(:each) do
				FactoryGirl.create(:rating, numeric_score: 1, story_id: @current_public_published_story.id)
				FactoryGirl.create(:rating, numeric_score: 7, story_id: @current_public_published_story.id)
				visit story_path(@current_public_published_story)
			end

			it "shows the story details" do
				should have_content("Eating Boogers")
				should have_content("Booger eating story...")
				should have_content("Junior")
			end

			it "shows the total ratings for the story" do	
				should have_content("Ha-Ha Rating: 4x (per 2 people)")
			end

			context "the story is authored by the current_user" do
				it "does NOT show 'ratings' buttons" do
					should_not have_button("1")
					should_not have_button("3")
				end
				it { should have_link("Edit Story") }
			end

			context "the story is not authored by the current_user" do
				before(:each) do
					@published_non_authored_story = FactoryGirl.create(:story, status: "published", published_date: Date.new(2012, 12, 3), share_type: "private", title: "My Published Private Story")
					visit story_path(@published_non_authored_story)
				end
				it "shows the 'ha-ha scale' buttons" do
					should have_button("0")
					should have_button("1")
					should have_button("3")
					should have_button("5")
					should have_button("7")
					should have_button("10")

				end
				it "should not have an 'Edit Story' link" do
					should_not have_link("Edit Story")
				end

				context "user rates the story for the first time" do
					context "user presses the '1' button" do
						before(:each) { click_button "1" }
					
						it "should create a '1' user rating for the story" do
							Rating.where(story_id: @published_non_authored_story.id).where(user_id: @user.id).first.numeric_score.should == 1
						end

						it "should return the user to the index stories path" do
							current_path.should == stories_path
						end
					end
					context "user presses '10' button" do
						it "should create a '10' user rating for the story" do
							click_button "10"
							Rating.where(story_id: @published_non_authored_story.id).where(user_id: @user.id).first.numeric_score.should == 10
						end	
					end
				end

				context "user has already rated the story" do
					before(:each) do 
						FactoryGirl.create(:rating, numeric_score: 1, story_id: @published_non_authored_story.id, user_id: @user.id)
						visit story_path(@published_non_authored_story)
					end

					it { should have_content("You gave this 1 Ha-Ha's") }
					it { should_not have_button("1") }
				end
			end
		end

		describe "ShowPage_comments_section" do
			before(:each) do
				@published_non_authored_story = FactoryGirl.create(:story, status: "published", published_date: Date.new(2012, 12, 3), share_type: "private", title: "My Published Private Story")
				@remark = FactoryGirl.create(:remark, story_id: @published_non_authored_story.id, user_id: @user.id)
				FactoryGirl.create(:remark, story_id: 99999, body: "I'm a remark not related to this story") # <- a remark not related to the current story.
				visit story_path(@published_non_authored_story)
			end
			
			it "allows the user to access the remark/new view" do
				click_on("Create Remark")
				current_path.should == new_remark_path
			end

			it "includes a listing of all the remarks for the story" do
				should have_content("That was the funniest thing I've ever read...")
				should_not have_content("I'm a remark not related to this story")
			end

			context "the current user authored the remark" do
				it { should have_link("Edit Remark") }
				it { should have_link("Delete") }
			
				it "routes the user to edit view when the user presses 'Edit'" do
					click_on("Edit Remark")
					current_path.should == edit_remark_path(@remark)
				end
			end

			context "the current user did not author the remark" do
				before(:each) do
					FactoryGirl.create(:remark, story_id: @current_public_published_story.id, user_id: 9999)
					visit story_path(@current_public_published_story)
				end

				it { should_not have_link("Edit Remark") }		
				it { should_not have_link("Delete") }
			end
		end

		context "there are previous published stories and a newer published stories as it relates to the current story" do
			before(:each) do
				@previous_public_published_story = FactoryGirl.create(:story, user_id: @user.id, id: 4, title: "Previous Public Published Story", status: "published", published_date: Date.new(2012, 12, 4), share_type: "public", title: "Eating Boogers", body: "Booger eating story...")
				@previous_private_published_story = FactoryGirl.create(:story, user_id: @user.id, id: 5, title: "Previous Private Published Story",status: "published", published_date: Date.new(2012, 12, 5), share_type: "private", title: "Eating Boogers", body: "Booger eating story...")
				@next_private_published_story = FactoryGirl.create(:story, user_id: @user.id, id: 7, title: "Newer Private Published Story", status: "published", published_date: Date.new(2012, 12, 7), share_type: "private", title: "Eating Boogers", body: "Booger eating story...")
				@next_public_published_story = FactoryGirl.create(:story,  user_id: @user.id, id: 8, title: "Newer Public Published Story", status: "published", published_date: Date.new(2012, 12, 8), share_type: "public", title: "Eating Boogers", body: "Booger eating story...")
			end

			context "user visits the show page for a public story via the index page or 'Read Funny'" do
		 		before(:each) { visit story_path(@current_public_published_story) }		

		 		
		
				it "includes a link to show the previous public published story" do
					click_on("<<")
					current_path.should == story_path(@previous_public_published_story)
				end

				it "includes a link to show the newer publich published story" do
					click_on(">>")
					current_path.should == story_path(@next_public_published_story)
				end
			end

			context "user visits the show page for a story via links to their personal stories" do
		 		before(:each) { visit story_path(@current_public_published_story, type: "personal") }		

				it "includes a link to show the previous published story (regardless of whether it is public or private)" do
					click_on("<<")
					current_path.should == story_path(@previous_private_published_story)
				end

				it "includes a link to show the newer published story (regardless of whether it is public or private)" do
					click_on(">>")
					current_path.should == story_path(@next_private_published_story)
				end
			end
		end

		context "there are NOT previous published stories and a newer published stories as it relates to the current story" do
			before(:each) { visit story_path(@current_public_published_story) }

			it "does NOT include a link to show the previous public published story" do
				should_not have_link("<<")
			end

			it "does NOT include a link to show the next public published story" do
				should_not have_link(">>")
			end
		end
	end #visitor signs in as a user

#--------------------------
	

		
			

end