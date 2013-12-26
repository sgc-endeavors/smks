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
	
		if user.is_admin?
			can :manage, Comment
		else
			can :read, Comment
			can :update, Comment do |comment|
				comment.user == user
			end
			can :destroy, Comment do |comment|
				comment.user == user
			end
		end




	end

end