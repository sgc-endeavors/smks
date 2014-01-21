require 'spec_helper'

describe "Story_Index Page" do

	before(:each) do
		@user = FactoryGirl.create(:user)
		2.times { FactoryGirl.create(:story, share_type: "public", status: "published", published_date: Date.new(2012, 12, 3), user_id: @user.id) }
		FactoryGirl.create(:rating, numeric_score: 1,  story_id: Story.first.id)
		FactoryGirl.create(:rating, numeric_score: 7, story_id: Story.first.id)
	end

	subject { page }

	context "a visitor has or has not logged in" do
		before(:each) do
			FactoryGirl.create(:story, title: "My Private Story", user_id: @user.id, status: "published", published_date: Date.new(2012, 12, 3), share_type: "private")
			FactoryGirl.create(:story, title: "My Draft Story", status: "draft", user_id: @user.id)
		end

		context "a story's body is more than 300 characters in length" do
			before(:each) do
				FactoryGirl.create(:story, title: "A Long Story", status: "published", published_date: Date.new(2012, 12, 3), share_type: "public", body: "Ice cream macaroon croissant cookie wafer jujubes. Lollipop lemon drops oat cake croissant dessert. Cookie cupcake lemon drops cotton candy cookie pudding caramels. Lollipop sweet biscuit cotton candy. Drage pastry jujubes cotton candy sesame snaps chocolate bar dessert lollipop. Sweet tiramisu donut.")
				visit stories_path(type: "public")
			end
			it { should have_link("...more") }
			 
		end

		context "a story's body is less than 300 characters in length" do
			before(:each) do
				visit stories_path(type: "public")
			end
			it { should_not have_link("...more") }
		end


		context "visitor wants to see all public stories" do
			before(:each) { visit stories_path(type: "public") }
			it "allows the visitor to view all public stories" do		
				should_not have_content("My Private Story")
			end

			context "has a side bar showing the week's most funny" do

				it "allows the visitor to view the most funny list" do
					should have_content("This Month's 10 Most Funny")
				end

				it "contains the five funniest stories of all time" do
					pending
				end
			end

			it "allows user to access the create story page" do 
				should have_link("Create")
			end

			it "does not show stories with a 'draft' status" do
				should_not have_content("My Draft Story")
			end

			it "includes a link to the stories 'show' page" do
				should have_link(Story.first.title)
			end

			it "shows the average rating for the story" do	
				should have_content("Ha-Ha Rating: 4x (per 2 people")
			end

			it "shows the first 300 characters of the story" do
				should have_content(Story.first.body[0..299])
			end

			it "shows the author's first name" do
				should have_content("By: #{Story.first.user.first_name}")
			end

			it "shows the date last_updated" do
				should have_content("on #{Story.first.published_date.strftime("%m/%d/%Y")}")
			end

		end
		# context "visitor wants to see all his private stories before logging in" do
		# 	before(:each) { visit stories_path(type: "private") }
		# 		current_path.should == new_sessions_path
		# end

	end

	context "a visitor has logged in" do
		
		context "user is NOT an Administrator" do	
			before(:each) do 
				sign_in_as_existing_user(@user) 
			end

			
			# it "allows the visitor to view all public stories and their own private stories" do
			# 	FactoryGirl.create(:story, title: "My Private Story", user_id: @user.id, status: "published", share_type: "private")
			# 	visit stories_path
			# 	should have_content("My Private Story")
			# end
			# it "does not allow the visitor to view others private stories" do
			# 	FactoryGirl.create(:story, title: "Someone Else's Private Story", share_type: "private")
			# 	visit stories_path
			# 	should_not have_content("Someone Else's Private Story")
			# end

			



			context "visitor wants to see all public stories" do
				before(:each) do 
					visit stories_path(type: "public")
				end

				context "user has 1 story in draft status" do
					before(:each) do
						FactoryGirl.create(:story, title: "My Draft Story", status: "draft", user_id: @user.id)
						visit stories_path(type: "public")
					end
					
					it "shows a link to the stories in draft status" do
						should have_link("Finish Draft(1)")
					end

					context "user presses 'Complete Drafts' link" do
						before(:each) { click_on("Finish Draft(1)") }
						it "routes user to the index page for draft stories" do
							#current_path.should == stories_path(type: "draft")
							should have_content("My Draft Story")
						end
						it "should display: 'Draft Stories'" do
							should have_content("My Draft Stories")
						end


					end

				end


				context "user has no stories in draft status" do
					it "shows a link to the stories in draft status" do
						visit stories_path(type: "public")
						should_not have_link("Finish Draft")
					end
				end

				it "allows user to access the story edit page for their stories" do 
					first(:link, "Edit Story").click
					current_path.should == edit_story_path(Story.first)
				end
				it "shows the edit link for only those stories authored by the user" do
					FactoryGirl.create(:story, published_date: Date.new(2012, 12, 3)) #
					should have_link("Edit Story", count: 2)
				end
				it "shows the delete link for only those stories authored by the user" do
					FactoryGirl.create(:story, published_date: Date.new(2012, 12, 3)) #
					should have_link("Delete", count: 2)
				end
				it "should not be able to access the edit view via the URL unless you authored the story" do
					visit edit_story_path(FactoryGirl.create(:story, published_date: Date.new(2012, 12, 3))) #
					current_path.should == root_path
				end

				it "should be titled 'Too Funny Not to Share'" do
					should have_content("Too Funny Not to Share")
				end
			end
		

			context "visitor wants to see all his public and private stories" do
				before(:each) do 
					FactoryGirl.create(:story, title: "My Private Story", user_id: @user.id, status: "published", published_date: Date.new(2012, 12, 3), share_type: "private")
					visit stories_path(type: "personal")
				end
				
				it "allows the visitor to view their own private stories AND public stories" do
					should have_content("My Private Story")
				end

				it "should be titled 'My Scrapbook'" do
					should have_content("My Scrapbook")
				end


				it "allows user to access the story edit page for their stories" do 
					first(:link, "Edit Story").click
					current_path.should == edit_story_path(Story.last)
				end
				it "shows the edit link for only those stories authored by the user" do
					FactoryGirl.create(:story, published_date: Date.new(2012, 12, 3)) #
					should have_link("Edit Story", count: 3)
				end
				it "shows the delete link for only those stories authored by the user" do
					FactoryGirl.create(:story, published_date: Date.new(2012, 12, 3)) #
					should have_link("Delete", count: 3)
				end
				it "should not be able to access the edit view via the URL unless you authored the story" do
					visit edit_story_path(FactoryGirl.create(:story, published_date: Date.new(2012, 12, 3))) #
					current_path.should == root_path
				end
			end

		end

		context "user IS an Administrator" do		
			before(:each) do 
				admin_user = FactoryGirl.create(:user, is_admin: true)
				sign_in_as_existing_user(admin_user)
				visit stories_path(type: "public")
			end
			
			it "shows the edit link for ALL stories" do
				should have_link("Edit Story", count: 2)
			end
			it "shows the delete link for ALL stories" do
				should have_link("Delete", count: 2)
			end
			it "should be able to access the edit view via the URL" do
				existing_story = FactoryGirl.create(:story, published_date: Date.new(2012, 12, 3))
				visit edit_story_path(existing_story) #
				current_path.should == edit_story_path(existing_story)
			end
		end	
	end

	context "visitor has NOT logged in" do
		it "does NOT allow visitor to click on the edit link" do
			visit stories_path(type: "public")
			should_not have_link("Edit Story")
		end

		it "only allows the visitor to view 'public' stories" do
			FactoryGirl.create(:story, title: "My Private Story", status: "published", published_date: Date.new(2012, 12, 3), user_id: @user.id, share_type: "private")
			visit stories_path(type: "public")
			should_not have_content("My Private Story")
		end

	end




end


