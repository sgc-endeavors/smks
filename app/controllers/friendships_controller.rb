class FriendshipsController < ApplicationController
  before_filter :authenticate_user!

  def create
  	@friendship = current_user.friendships.build(friend_id: params[:friend_id])
    @friendship.hide_content = false
  	@friendship.save!
  	redirect_to friendships_path
  end


  def index
		if params[:search] && params[:search] != ""
			@users = User.where("email ilike ?", "%#{params[:search]}%").all#.where('name not like', "#{current_user.email}").all
		else
      @users = nil
    end
		@friendships = current_user.friendships
    @inverse_friendships = current_user.inverse_friendships
		render :index
	end

  def update
    @friendship = Friendship.find(params[:id])
    if @friendship.hide_content == true
      @friendship.hide_content = false
    else
      @friendship.hide_content = true
    end
    @friendship.save!
    redirect_to friendships_path
  end


  def destroy
  	friendship = current_user.friendships.find(params[:id])
  	friendship.destroy
  	redirect_to friendships_path
  end
end
