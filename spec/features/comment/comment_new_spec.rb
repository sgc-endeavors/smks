require 'spec_helper'

describe "Comment_New Page" do 
	subject { page }

	let(:story) { FactoryGirl.create(:story) }
	let(:new_comment) { FactoryGirl.build(:comment, story_id: story.id, user_id: story.user.id) }

	
	context "user is NOT logged in" do
		it "user should not be able to add visit the new_comment_path via the URL" do
			visit new_comment_path(story_id: story.id)
			current_path.should == new_user_session_path
		end
	end

	context "user is logged in" do
	before(:each) do
		user = story.user
		sign_in_as_existing_user(user)
		visit new_comment_path(story_id: story.id)
	end

 	it { should have_content("Create a Comment") }

	it "saves the new comment information upon submission" do
		submit_a_new_comment(new_comment)
 		last_comment = Comment.last
	 	last_comment.body.should == new_comment.body
	 	last_comment.user_id.should == new_comment.user_id		
 		last_comment.story_id.should == new_comment.story_id
 end

  it "shows the related story's show page after submission" do
  	submit_a_new_comment(new_comment)
 		current_path.should == story_path(Comment.last.story)
  end

end



end