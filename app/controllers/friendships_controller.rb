class FriendshipsController < ApplicationController
  def create
  	@friendship = current_user.friendships.build(friend_id: params[:friend_id])
  	@friendship.save!
  	redirect_to users_path
  end

  def destroy
  end
end
