require 'spec_helper'

describe "Remark_New Page" do 
	subject { page }

	let(:story) { FactoryGirl.create(:story) }
	let(:new_remark) { FactoryGirl.build(:remark, story_id: story.id, user_id: story.user.id) }

	
	context "user is NOT logged in" do
		it "user should not be able to visit the new_remark_path via the URL" do
			visit new_remark_path(story_id: story.id)
			current_path.should == new_user_session_path
		end
	end

	context "user is logged in" do
		before(:each) do
			user = story.user
			sign_in_as_existing_user(user)
			visit new_remark_path(story_id: story.id)
		end

 		it { should have_content("Create a Remark") }

		it "saves the new remark information upon submission" do
			submit_a_new_remark(new_remark)
	 		last_remark = Remark.last
		 	last_remark.body.should == new_remark.body
		 	last_remark.user_id.should == new_remark.user_id		
	 		last_remark.story_id.should == new_remark.story_id
	 	end

	  it "shows the related story's show page after submission" do
	  	submit_a_new_remark(new_remark)
	 		current_path.should == story_path(Remark.last.story)
	  end
	end
end