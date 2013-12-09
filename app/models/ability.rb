class Ability
	include CanCan::Ability
	
	def initialize(user)
		user ||= User.new
		
		if user.is_admin?
			can :manage, Story
		else
			can :read, Story
			can :update, Story do |story|
				story.user == user
			end
			can :destroy, Story do |story|
				story.user == user
			end
		end
	end

end