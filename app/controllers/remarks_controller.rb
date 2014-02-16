class RemarksController < ApplicationController
	before_filter :authenticate_user!
	
	def new
		@new_remark = Remark.new
		@story_id = params[:story_id]
		authorize! :create, Remark
		render :new
	end

	def create
		new_remark = Remark.new(params[:remark])
		new_remark.user_id = current_user.id
		new_remark.save!
		redirect_to story_path(new_remark.story)
	end

	def edit
		@remark = Remark.find(params[:id])
		authorize! :update, @remark
		render :edit
	end

	def update
		updated_remark = Remark.find(params[:id])
		updated_remark.update_attributes(params[:remark])
		redirect_to story_path(updated_remark.story)
	end

	def destroy

	end

end
