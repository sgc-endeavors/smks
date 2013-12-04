class StoriesController < ApplicationController
	before_filter :authenticate_user!, except: [ :index ]

 def index
 	@existing_stories = Story.all
 	render :index
 end

 def new #(get)
 	@new_story = Story.new
 	render :new
 end

 def create #(post)
 	new_story = Story.new(params[:story])
 	new_story.user_id = current_user.id
 	new_story.save!
 	redirect_to story_path(new_story)
 end

def show #(get)
 	@existing_story = Story.find(params[:id])
 	render :show
end

def edit #(get)
	@current_story = Story.find(params[:id])
	render :edit
end

def update #(post/put)
	updated_story = Story.find(params[:id])
	updated_story.update_attributes(params[:story])
	redirect_to story_path(updated_story)
end

end

