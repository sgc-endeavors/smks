require 'spec_helper'

describe "Comment_Edit Page" do 
	subject { page }

	let(:story) { FactoryGirl.create(:story) }
	let(:comment) { FactoryGirl.create(:comment, story_id: story.id, user_id: story.user.id) }

	before(:each) do
		user = story.user
		sign_in_as_existing_user(user)
		visit edit_comment_path(comment.id)
	end

 	it { should have_content("Edit My Comment") }

	it "saves the updated comment information upon submission" do
		update_an_existing_comment(comment)
		updated_comment = Comment.find(comment.id)
		updated_comment.body.should == "That was the dumbest thing I've ever read..."
	end

  it "shows the related story's show page after submission" do
  	update_an_existing_comment(comment)
 		current_path.should == story_path(comment.story)
  end

  it "should not be accessible if the current user did not author the comment" do
  	a_non_authored_comment = FactoryGirl.create(:comment) 
  	visit edit_comment_path(a_non_authored_comment.id)
  	current_path.should == root_path

  end

end