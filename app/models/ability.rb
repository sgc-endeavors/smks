class Ability
	include CanCan::Ability
	
	def initialize(user)
		user ||= User.new
#		can :read, Story
		can :read, Story
		can :update, Story do |story|
			story.user == user
		end

	end

end