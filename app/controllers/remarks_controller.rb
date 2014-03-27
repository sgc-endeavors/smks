class RemarksController < ApplicationController
	before_filter :authenticate_user!
	
	def index
		@remarks = Remark.where(viewed: nil).all(joins: :story, conditions: {stories: { user_id: current_user.id }})


	end
	
	def new
		@remark = Remark.new
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
		@story_id = @remark.story_id
		authorize! :update, @remark
		render :edit
	end

	def update

		if params[:viewed] == "true"
			viewed_remark = Remark.find(params[:id])
			viewed_remark.viewed = true
			viewed_remark.save!
			redirect_to remarks_path
		else
			updated_remark = Remark.find(params[:id])
			updated_remark.update_attributes(params[:remark])
			redirect_to story_path(updated_remark.story)
		end
	end

	def destroy
		remark = Remark.find(params[:id])
		remark.destroy
		redirect_to story_path(remark.story_id)

	end

end
