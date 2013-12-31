class StoriesController < ApplicationController
	before_filter :authenticate_user!, except: [ :landing_page, :index, :show ]

 def landing_page
 	render :landing_page, layout:false
 end


 def index
 	unless current_user == nil
 		@draft_stories_count = Story.where(status: "draft").where(user_id: current_user.id).count
 	end

 	@type = params[:type]
 	if params[:type] == "public" || params[:type] == nil
 			@existing_stories = Story.where(share_type: "public").where(status: "published")	
 	elsif params[:type] == "personal"
		 	@existing_stories = Story.where(share_type: "private").where(status: "published").where(user_id: current_user.id) + Story.where(share_type: "public").where(status: "published").where(user_id: current_user.id)
 	elsif params[:type] == "draft"
		@existing_stories = Story.where(status: "draft").where(user_id: current_user.id)
 	end
 	render :index
 end

 def new #(get)
 	@new_story = Story.new
 	render :new
 end

 def create #(post)
 	new_story = Story.new(params[:story])
 	new_story.user_id = current_user.id
 	new_story.status = if params[:submit]
 		"published"
 	else
 		"draft"
 	end
 	new_story.save!
 	redirect_to story_path(new_story)
 end

	def show #(get)
	 	@existing_story = Story.find(params[:id])
	 	# if current_user == nil   
	 	# 	@rating = Rating.new
	 	# else
	 	# 	@rating = Rating.where(story_id: @existing_story.id).where(user_id: current_user.id).first || Rating.new
	 	# end
	 	# @ratings = Rating.where(story_id: @existing_story.id)
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
		updated_story.status = if params[:update]
 			"published"
 		else
 			"draft"
 		end
 		updated_story.save!
		redirect_to story_path(updated_story)
	end

	def destroy #(post/delete)
		Story.find(params[:id]).destroy
		redirect_to stories_path(type: "personal")
	end
end

