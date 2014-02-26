require 'spec_helper'

describe "Story_Index Page" do
	
	subject { page }

	before(:each) do 
		@user = FactoryGirl.create(:user)
		@public_published_short_story = FactoryGirl.create(:story, title: "A Public Published Short Story", share_type: "public", status: "published", published_date: Date.new(2012, 12, 3))
		@private_published_story = FactoryGirl.create(:story, title: "My Private Story", user_id: @user.id, status: "published", published_date: Date.new(2012, 12, 3), share_type: "private")
	end

	context "a visitor has or has not logged in" do

		before(:each) do
			#2.times { FactoryGirl.create(:story, share_type: "public", status: "published", published_date: Date.new(2012, 12, 3), user_id: @user.id) }
			@draft_story = FactoryGirl.create(:story, title: "My Draft Story", status: "draft", user_id: @user.id)
		end

		context "visitor visits the index page" do
			before(:each) { visit stories_path(type: "public") }
			
			it "allows the visitor to view all public published stories" do		
				should_not have_content("My Private Story")
				should_not have_content("My Draft Story")
				should have_content("A Public Published Short Story")
			end

			it "allows user to access the create story page" do 
				should have_link("Create")
			end

			it "includes a link to the stories 'show' page" do
				should have_link(@public_published_short_story.title)
			end

			context "the public published short story has received 2 ratings" do
				before(:each) do
					FactoryGirl.create(:rating, numeric_score: 1, story_id: @public_published_short_story.id)
					FactoryGirl.create(:rating, numeric_score: 7, story_id: @public_published_short_story.id)
					visit stories_path(type: "public")
				end
				it "shows the average rating for a story with ratings" do	
					should have_content("Ha-Ha Rating: 4x (per 2 people")
				end
			end

			context "a story has more than 300 characters" do
				before(:each) do
					@public_published_long_story = FactoryGirl.create(:story, title: "A Long Story", status: "published", published_date: Date.new(2012, 12, 3), share_type: "public", body: "Ice cream macaroon croissant cookie wafer jujubes. Lollipop lemon drops oat cake croissant dessert. Cookie cupcake lemon drops cotton candy cookie pudding caramels. Lollipop sweet biscuit cotton candy. Drage pastry jujubes cotton candy sesame snaps chocolate bar dessert lollipop. Sweet tiramisu donut.")
					visit stories_path(type: "public")
				end

				it "shows the first 300 characters of the story" do
					should have_content(@public_published_long_story.body[0..299])
				end
				it { should have_link("...more") }

			end

			it "shows the author's first name" do
				should have_content("By: #{@public_published_short_story.user.first_name}")
			end

			it "shows the date last_updated" do
				should have_content("on #{@public_published_short_story.published_date.strftime("%m/%d/%Y")}")
			end

			describe "Index#Sidebar" do

				it "allows the visitor to view the most funny list" do
					should have_content("This Month's 10 Most Funny")
				end

				it "contains the five funniest stories of all time" do
					pending
				end
			end
		end
	end


	context "visitor has logged in as a user" do	
		before(:each) do 
			sign_in_as_existing_user(@user) 
		end

		context "visitor wants to see all public stories" do
			before(:each) do 
				visit stories_path(type: "public")
			end

			it "should not be able to access the edit view via the URL unless you authored the story" do
				visit edit_story_path(FactoryGirl.create(:story, published_date: Date.new(2012, 12, 3))) #
				current_path.should == root_path
			end

			it "should be titled 'Too Funny Not to Share'" do
				should have_content("Too Funny Not to Share")
			end	

			context "visitor has authored 1 public story" do
				before(:each) do
					#private_story above +
					@another_story = FactoryGirl.create(:story, status: "published", user_id: @user.id, published_date: Date.new(2012, 12, 3), share_type: "public")
					@image_for_another_story = FactoryGirl.create(:image, story_id: @another_story.id)
					@rating_for_another_story = FactoryGirl.create(:rating, story_id: @another_story.id)
					@remark_for_another_story = FactoryGirl.create(:remark, story_id: @another_story.id)

					visit stories_path(type: "public")	
				end

				it "allows user to access the story edit page for their stories" do 
					first(:link, "Edit Story").click
					current_path.should == edit_story_path(@another_story.id)
				end
				it "shows the edit link for only those public published stories authored by the user" do
					should have_link("Edit Story", count: 1)
				end
				it "shows the delete link for only those public published stories authored by the user" do
					should have_link("Delete", count: 1)
				end

				context "users wants to delete the story" do
					before(:each) { click_on "Delete" }
						it "deletes the story" do
							expect { Story.find(@another_story.id)}.to raise_error(ActiveRecord::RecordNotFound)	
						end
						it "deletes the image associated with the story" do
							expect { Image.find(@image_for_another_story.id)}.to raise_error(ActiveRecord::RecordNotFound)	
						end
						it "deletes the remarks associated with the story" do
							expect { Remark.find(@remark_for_another_story.id)}.to raise_error(ActiveRecord::RecordNotFound)	
						end
						it "deletes the ratings associated with the story" do
							expect { Rating.find(@rating_for_another_story.id)}.to raise_error(ActiveRecord::RecordNotFound)	
						end

				end
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
		end
	
		context "visitor wants to see all his public and private stories" do
			before(:each) do 
				@another_story = FactoryGirl.create(:story, title: "My Private Story", user_id: @user.id, status: "published", published_date: Date.new(2012, 12, 3), share_type: "private")
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
				should have_link("Edit Story", count: 2)
			end
			it "shows the delete link for only those stories authored by the user" do
				should have_link("Delete", count: 2)
			end
			it "should not be able to access the edit view via the URL unless you authored the story" do
				visit edit_story_path(FactoryGirl.create(:story, published_date: Date.new(2012, 12, 3))) #
				current_path.should == root_path
			end
		end
	end	

	context "visitor has NOT logged in" do
		before(:each) { visit stories_path(type: "public") }
		
		it "does NOT allow visitor to click on the edit link" do
			should_not have_link("Edit Story")
		end

		it "only allows the visitor to view 'public' stories" do
			should_not have_content("My Private Story")
		end
	end
end


