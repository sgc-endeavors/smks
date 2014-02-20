class FriendshipsController < ApplicationController
  before_filter :authenticate_user!

  def create
  	@friendship = current_user.friendships.build(friend_id: params[:friend_id])
  	@friendship.save!
  	redirect_to friendships_path
  end


  def index
		if params[:search] && params[:search] != ""
			@users = User.where("email ilike ?", "%#{params[:search]}%").all#.where('name not like', "#{current_user.email}").all
		end
		@friendships = current_user.friendships
		render :index
	end


  def destroy
  	friendship = current_user.friendships.find(params[:id])
  	friendship.destroy
  	redirect_to friendships_path
  end
end
