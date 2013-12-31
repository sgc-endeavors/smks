class CommentsController < ApplicationController
	before_filter :authenticate_user!
	
	def new
		@new_comment = Comment.new
		@story_id = params[:story_id]
		authorize! :create, Comment
		render :new
	end

	def create
		new_comment = Comment.new(params[:comment])
		new_comment.user_id = current_user.id
		new_comment.save!
		redirect_to story_path(new_comment.story)
	end

	def edit
		@comment = Comment.find(params[:id])
		authorize! :update, @comment
		render :edit
	end

	def update
		updated_comment = Comment.find(params[:id])
		updated_comment.update_attributes(params[:comment])
		redirect_to story_path(updated_comment.story)
	end

	def destroy

	end

end
