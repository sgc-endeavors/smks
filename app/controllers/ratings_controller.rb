class RatingsController < ApplicationController

def create
	rating = Rating.new
 	rating.numeric_score = params[:rating].to_i 
		rating.story_id = params[:story_id]
		rating.user_id = current_user.id
		rating.save!
		redirect_to stories_path
end

# def update
# 	end


end

