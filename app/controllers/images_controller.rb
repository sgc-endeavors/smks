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
#		if params[:type] == "homepage_image"
			@type = "homepage_image" if params[:type] == "homepage_image"
#		else
			@story_id = params[:story_id]
#		end

	end

	def create
		new_image = Image.new
	 	new_image.s3_image_loc = params[:s3_image_loc]
	 	new_image.user_id = current_user.id
	 	if params[:type_of_image] == "homepage_image"
	 		new_image.show_on_homepage = true
	 		new_image.save!
	 		redirect_to root_path
	 	else	
	 		new_image.story_id = params[:story_id]
	 		new_image.save!
			redirect_to edit_story_path(params[:story_id])
	 	end
	end



	def edit
		@image = current_user.images.find(params[:id])
		@type = "homepage_image" if params[:type] == "homepage_image"
		@story_id = @image.story_id
		
	end

	def update
		updated_image = Image.find(params[:id])
		updated_image.s3_image_loc = params[:s3_image_loc]

		if params[:type_of_image] == "homepage_image"
	 		updated_image.show_on_homepage = true
	 		updated_image.save!
	 		redirect_to root_path
	 	else	
	 		updated_image.story_id = params[:story_id]
	 		updated_image.save!
			redirect_to edit_story_path(params[:story_id])
	 	end
	end

end
