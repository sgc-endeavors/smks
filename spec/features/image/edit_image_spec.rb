require 'spec_helper'

describe "Edit Image Page" do
	subject { page }

	context "a user has authored a story and created a corresponding image" do
		before(:each) do
			@user = FactoryGirl.create(:user)
		  @story = FactoryGirl.create(:story, published_date: Date.new(2012, 12, 3), user_id: @user.id, title: "Eating Boogers", body: "Booger eating story...")
		  @existing_image = FactoryGirl.create(:image, story_id: @story.id, user_id: @user.id)
		end


		context "visitor has not signed in" do
			context "visitor visits the edit_image_path" do
				before(:each) { visit edit_image_path(@existing_image) }
				
				it "routes the user to the new user session path" do
					current_path.should == new_user_session_path
				end
			end
		end

		context "visitor has signed in" do
			before(:each) do			
		    sign_in_as_existing_user(@user)
		  end

		  context "user wishes to replace the existing image" do
		  	before(:each) { visit edit_image_path(@existing_image) }

		  	it { should have_content("Update Image") }
		  	it { should have_button("Submit") }
		  	it { should have_link("Cancel") }

		  	context "user decides not to replace the image" do
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




		end
	end
end