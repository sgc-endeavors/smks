require 'spec_helper'

describe "Devise#cancel_my_account" do 
	
	subject { page }

	let(:user) { FactoryGirl.create(:user) }

	context "visitor has logged in as a user" do
		before(:each) { sign_in_as_existing_user(user) }
		
		context " user has created 2 stories, 2 images, remarks, ratings and people" do
			before(:each) do 
				@story1 = FactoryGirl.create(:story, user_id: user.id)
				@story2 = FactoryGirl.create(:story, user_id: user.id)
				@image1 = FactoryGirl.create(:image, user_id: user.id, story_id: @story1.id)
				@image2 = FactoryGirl.create(:image, user_id: user.id, story_id: @story2.id)
				@users_remark = FactoryGirl.create(:remark, user_id: user.id)
				@others_remark_about_story1 = FactoryGirl.create(:remark, story_id: @story1.id)
				@users_rating = FactoryGirl.create(:rating, user_id: user.id)
				@others_rating_about_story1 = FactoryGirl.create(:rating, story_id: @story1.id)
				@users_person = FactoryGirl.create(:person, user_id: user.id)
				@users_friendship = FactoryGirl.create(:friendship, user_id: user.id)
				@user_befriended = FactoryGirl.create(:friendship, friend_id: user.id)
			end


			context 'user wants to cancel their account' do
				before(:each) do
					cancel_account(user)
				end

				it "deletes the user from the User model" do
					expect {User.find(user.id)}.to raise_error(ActiveRecord::RecordNotFound)
				end

				it "deletes each of the user's stories" do
						expect { Story.find(@story1.id)}.to raise_error(ActiveRecord::RecordNotFound)							
						expect { Story.find(@story2.id)}.to raise_error(ActiveRecord::RecordNotFound)	
				end

				it "deletes each person associated w/ a deleted user" do
					expect { Person.find(@users_person.id)}.to raise_error(ActiveRecord::RecordNotFound)
				end

				it "deletes each friendship associated w/ a deleted user" do
					expect { Friendship.find(@users_friendship.id)}.to raise_error(ActiveRecord::RecordNotFound)
				end

				it "deletes each friendship in which the deleted user was 'befriended' by another user" do
					expect { Friendship.find(@user_befriended.id)}.to raise_error(ActiveRecord::RecordNotFound)
				end

				it "deletes each image associated w/ a story of the deleted user" do
					expect { Image.find(@image1.id)}.to raise_error(ActiveRecord::RecordNotFound)
					expect { Image.find(@image2.id)}.to raise_error(ActiveRecord::RecordNotFound)
				end

				it "deletes each remark associated w/ a story of the deleted user" do
					expect { Remark.find(@others_remark_about_story1.id)}.to raise_error(ActiveRecord::RecordNotFound)
				end

				it "does NOT delete each remark created by the deleted user" do
					Remark.find(@users_remark.id).should_not be_nil
				end

				it "deletes each rating associated w/ a story of the deleted user" do
					expect { Rating.find(@others_rating_about_story1.id)}.to raise_error(ActiveRecord::RecordNotFound)
				end

				it "does NOT delete each remark created by the deleted user" do
					Rating.find(@users_rating.id).should_not be_nil
				end

			end #context visitor wanst to cancel
		end #context created 2 polls
	end #context visitor login

end