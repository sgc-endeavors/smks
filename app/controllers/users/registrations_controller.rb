class Users::RegistrationsController < Devise::RegistrationsController

	def destroy
    befriended_users = Friendship.where(friend_id: current_user.id)
    befriended_users.each do |befriended_user|
    	befriended_user.destroy
    end
	  
    super
  end

  # def create
  # 	super

  # 	new_person = Person.new
  # 	new_person.name = params[:user][:first_name]
  # 	new_person.save!
  # end


end