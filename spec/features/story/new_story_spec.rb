require 'spec_helper'

describe "Story_New Page" do 
	subject { page }

	context "visitor has not signed in as a user" do
    context "visitor trys to visit the new stories path" do
      before(:each) { visit new_story_path }
      
      it "routes the user to the sign in page" do
        current_path.should == new_user_session_path
      end
    end
  end

	context "visitor signs in as a user and visits the stories path" do
		let(:user) { FactoryGirl.create(:user, default_share_preference: "private") }		
		let(:new_story) { FactoryGirl.build(:story, user_id: user.id, person_id: @person.id) }
		before(:each) do 
			@person = FactoryGirl.create(:person, user_id: user.id)
			sign_in_as_existing_user(user)
			visit stories_path
		end

		context "user submits a new story" do
			let(:last_story) { Story.last }

			context "using the 'Create' link" do
				before(:each) { click_on "Create" }
				
				it "defaults to the user's share preference unless it is overwrittern" do
					publish_a_new_story(new_story)
		 		 	last_story.share_type.should == 'private'
				end
			end

			context "user visits the new story page EITHER WAY" do
				before(:each) { visit new_story_path }		

			  context "user wants to assign a child's name to the story" do
			  	before(:each) { click_on "Add Child/Person" }
			  	
			  	it "routes the user to the new person path" do
			  		current_path.should == people_path
			  	end
			  end

			  context "user wants to publish a new story" do
				  before(:each) { publish_a_new_story(new_story) }

				  it "saves the new story information upon submission" do
				 		last_story.title.should == new_story.title
				 		last_story.body.should == new_story.body
				 		last_story.share_type.should == "private"
				 		last_story.person.name.should == "Junior"
				 		last_story.user_id.should == new_story.user_id	
				 		last_story.status.should == "published"
				 		last_story.published_date.should_not be_nil	
				  end
				  it "shows the new story's page" do
				 		current_path.should == story_path(last_story)
				  end
				end
			
				#context "user did not want to save an image" do
					#it does not try to save a new image.
				#end

				context "user wants to save the new story as a draft for the time being" do
				  before(:each) { save_draft_of_a_new_story(new_story) }
				  it "saves the new story information upon submission" do
				 		last_story.title.should == new_story.title
				 		last_story.body.should == new_story.body
				 		last_story.share_type.should == "private"
				 		last_story.user_id.should == new_story.user_id	
				 		last_story.status.should == "draft"		
				 		last_story.published_date.should be_nil
				  end
				  it "shows the new story's page" do
				 		current_path.should == story_path(last_story)
				  end
				end

				context "user presses cancel" do
				  before(:each) { click_on "Cancel" }

			  	it "routes the user back to the stories_path upon cancel" do
				  	current_path.should == stories_path
					end
				end
			end
		end
	end
end




