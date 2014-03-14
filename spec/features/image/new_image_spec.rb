require 'spec_helper'

describe "New Image Page" do
	subject { page }

	context "a user has authored a story and not created a corresponding image" do
		before(:each) do
			@user = FactoryGirl.create(:user)
		  @story = FactoryGirl.create(:story, published_date: Date.new(2012, 12, 3), user_id: @user.id, title: "Eating Boogers", body: "Booger eating story...")
		end


		context "visitor has not signed in" do
			context "visitor visits the new_image_path" do
				before(:each) { visit new_image_path(story_id: @story.id) }
				
				it "routes the user to the new user session path" do
					current_path.should == new_user_session_path	
				end
			end
		end

		context "visitor has signed in" do
			before(:each) do			
		    sign_in_as_existing_user(@user)
		  end

		  context "user wishes to add an image to a story" do
		  	before(:each) { visit new_image_path(story_id: @story.id) }

		  	it { should have_content("Add Image") }
		  	it { should have_button("Submit") }
		  	it { should have_link("Cancel") }

		  	context "user decides not to add an image to the story" do
		  		before(:each) { click_on "Cancel" }
		  		it "routes the user back to the edit story_path" do
		  			current_path.should == edit_story_path(@story)
		  		end
		  	end

		  	context "user selects a new image and presses submit" do
		  		before(:each) do
		  			click_on "Submit"
		  		end
		  		it "routes the user back to the edit story_path" do
		  			current_path.should == edit_story_path(@story)
		  		end

					it "saves the new image" do
            pending
          end

		  	end


		  end

		  context "user wishes to add an image to their homepage" do
		   	before(:each) { visit new_image_path(type: "homepage_image") }
		  	context "user selects a new image and presses submit" do
		  		before(:each) do
		  			click_on "Submit"
		  		end
		  		it "routes the user back to the root_path" do
		  			current_path.should == root_path
		  		end

		  		it "saves the new image" do
            Image.last.show_on_homepage.should == true
          end
		  	end

		  	context "user decides not to add an image to thei homepage" do
		  		before(:each) { click_on "Cancel" }
		  		it "routes the user back to the root_path" do
		  			current_path.should == root_path
		  		end
		  	end





		  end




		end
	end
end