class ImagesController < ApplicationController

	before_filter :authenticate_user!

	def destroy
		story_id = current_user.images.find(params[:id]).story_id
		deleted_image = current_user.images.find(params[:id])
		deleted_image.destroy
		redirect_to edit_story_path(story_id)
	end

	def new
		@image = Image.new
		@story_id = params[:story_id]
	end

	def create
		new_image = Image.new
	 	new_image.s3_image_loc = params[:s3_image_loc]
	 	new_image.user_id = current_user.id
	 	new_image.story_id = params[:story_id]
	 	new_image.save!

		redirect_to edit_story_path(params[:story_id])
	end



	def edit
		@image = current_user.images.find(params[:id])
		
	end

	def update
		updated_image = Image.find(params[:id])
		updated_image.s3_image_loc = params[:s3_image_loc]
		updated_image.save!
		redirect_to edit_story_path(updated_image.story)
	end

end
