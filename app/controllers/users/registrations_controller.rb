class Users::RegistrationsController < Devise::RegistrationsController

	 def destroy
    befriended_users = Friendship.where(friend_id: current_user.id)
    befriended_users.each do |befriended_user|
    	befriended_user.destroy
    end
	  
    super

  end
end