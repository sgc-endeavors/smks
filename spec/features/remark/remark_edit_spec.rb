require 'spec_helper'

describe "Remark_Edit Page" do 
	subject { page }

	let(:story) { FactoryGirl.create(:story) }
	let(:remark) { FactoryGirl.create(:remark, story_id: story.id, user_id: story.user.id) }

	before(:each) do
		user = story.user
		sign_in_as_existing_user(user)
		visit edit_remark_path(remark.id)
	end

 	it { should have_content("Edit My Remark") }

	it "saves the updated remark information upon submission" do
		update_an_existing_remark(remark)
		updated_remark = Remark.find(remark.id)
		updated_remark.body.should == "That was the dumbest thing I've ever read..."
	end

  it "shows the related story's show page after submission" do
  	update_an_existing_remark(remark)
 		current_path.should == story_path(remark.story)
  end

  it "should not be accessible if the current user did not author the remark" do
  	a_non_authored_remark = FactoryGirl.create(:remark) 
  	visit edit_remark_path(a_non_authored_remark.id)
  	current_path.should == root_path

  end

end