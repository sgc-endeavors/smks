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
			can :manage, Remark
		elsif user.id != nil
			can :create, Remark
		end
			can :read, Remark
			can :update, Remark do |remark|
				remark.user == user
			end
			can :destroy, Remark do |remark|
				remark.user == user
			end
	end

end