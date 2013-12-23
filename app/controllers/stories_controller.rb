class StoriesController < ApplicationController
	before_filter :authenticate_user!, except: [ :landing_page, :index, :show ]

 def landing_page
 	render :landing_page
 end


 def index
 	@existing_stories = Story.all
 	#@ratings = Rating.all
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
	 	if current_user == nil   
	 		@rating = Rating.new
	 	else
	 		@rating = Rating.where(story_id: @existing_story.id).where(user_id: current_user.id).first || Rating.new
	 	end
	 	@ratings = Rating.where(story_id: @existing_story.id)
	 	@comments = Comment.where(story_id: @existing_story.id)
	 	render :show
	end

	def edit #(get)
		@current_story = Story.find(params[:id])
		authorize! :update, @current_story
		render :edit
	end

	def update #(post/put)
		updated_story = Story.find(params[:id])
		updated_story.update_attributes(params[:story])
		redirect_to story_path(updated_story)
	end

	def destroy #(post/delete)
		Story.find(params[:id]).destroy
		redirect_to root_path
	end
end

