require 'spec_helper'

describe "Story_Edit Page" do 
	subject { page }

  context "visitor has not signed in as a user" do
    context "visitor trys to visit the edit path" do
      before(:each) do
        story = FactoryGirl.create(:story)    
        visit edit_story_path(story)
      end
      it "routes the user to the sign in page" do
        current_path.should == new_user_session_path
      end
    end
  end

  context "visitor signs in as a user" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in_as_existing_user(@user)
    end

    context "user wants to edit an authored published story" do
      before(:each) do
    		@published_story = FactoryGirl.create(:story, published_date: Date.new(2012, 12, 3), user_id: @user.id, title: "Eating Boogers", body: "Booger eating story...")
        second_person = FactoryGirl.create(:person, name: "Jasmine", user_id: @user.id)
        visit edit_story_path(@published_story)	
    	end

     	it "displays the existing story's information in the form" do
     		should have_field("title", with: "Eating Boogers")
     		should have_field("body", with: "Booger eating story...")
        #I'm not sure how to write this test for dropdown boxes.
      end

      context "story does not have an associated image" do
        before(:each) do
          @published_story = FactoryGirl.create(:story, published_date: Date.new(2012, 12, 3), user_id: @user.id, title: "Eating Boogers", body: "Booger eating story...")
          visit edit_story_path(@published_story) 
        end

        it "displays the 'choose file' button " do
          pending
        end

        it { should_not have_link "Delete" }
        it { should_not have_link "Replace" }
        it { should have_link "Add Image" }

      end

      context "story has an associated image" do
        before(:each) do
          @image = FactoryGirl.create(:image, story_id: @published_story.id, user_id: @user.id)
          visit edit_story_path(@published_story) 
        end
      
        context "user wants to modify the photo associated with the story" do
          context "user wants to delete the photo" do
            it { should have_link "Delete" }
            context "user presses delete" do
              before(:each) { click_on "Delete" }

              it "deletes the image" do
                expect {Image.find(@image)}.to raise_error(ActiveRecord::RecordNotFound)
              end
              
              it "routes the user back to the 'show page'" do
                current_path.should == edit_story_path(@published_story)
              end
            end
          end
          context "user wants to change the image" do
            it { should have_link "Replace" }
            context "user presses 'Replace' " do
              before(:each) { click_on "Replace"}
            
              it "routes the user to the image edit view" do
                current_path.should == edit_image_path(@image)
              end
            end

          end



        end
      end
     
      context "user makes edits to the story" do
        let(:updated_story) { Story.find(@published_story.id) }
        before(:each) { update_existing_story }

        context "user presses 'Publish'" do
          before(:each) { click_on "Publish" }
          
          it "successfully saves the story information and routes them back to the show page" do
            updated_story.title.should == "Eating Burgers"
            updated_story.body.should == "Burger eating story..."
            updated_story.share_type.should == "private"
            updated_story.person.name.should == "Jasmine"
            updated_story.status.should == "published"
          end

          context "user has already published the story once before" do
            it "does not update the publish date" do
              updated_story = Story.find(@published_story)
              updated_story.published_date.should == @published_story.published_date
            end
          end

          it "routes the user back to the story show page" do
            current_path.should == story_path(updated_story)
          end
        end

        context "user presses 'Save as Draft'" do
          before(:each) { click_on "Save as Draft" }

          it "successfully saves the story information changes" do
            updated_story.title.should == "Eating Burgers"
            #chose not to test any other fields
          end

          it "changes the story's status to 'draft' but does not change the 'published_date' " do
            updated_story.status.should == "draft"
            updated_story.published_date.should == @published_story.published_date
          end
          
          it "routes the user back to the story show page" do  
            current_path.should == story_path(updated_story)
          end
        end

        context "users presses cancel" do
          before(:each) { click_on "Cancel" }
            
          it "does NOT save the story information" do
            updated_story.title.should == "Eating Boogers"
          end 
          
          it "routes the user back to the show page" do
            current_path.should == story_path(@published_story)
          end
        end
      end
    end

    context "user wants to edit an authored unpublished story" do
      before(:each) do
        @unpublished_story = FactoryGirl.create(:story, user_id: @user.id, title: "Eating Boogers", body: "Booger eating story...")
        second_person = FactoryGirl.create(:person, name: "Jasmine", user_id: @user.id)
        visit edit_story_path(@unpublished_story) 
      end

      context "user edits content" do
        let(:updated_story) { Story.find(@unpublished_story) }
        before(:each) { update_existing_story }
      
        context "user presses 'Publish' " do
          before(:each) { click_on "Publish" }
          
          it "sets a published_date for the story" do
            updated_story.published_date.should_not be_nil
            updated_story.status.should == "published"
          end
        end

        context "user presses 'Save as Draft' " do
          before(:each) { click_on "Save as Draft" }
          
          it "does NOT set a published_date for the story" do
            updated_story.published_date.should be_nil
            updated_story.status.should == "draft"
          end
        end
      end
    end
  end
end

