class UsersController < ApplicationController
  
  def new
    render :new
  end

  def create
  	user = User.new
  	user.user_first = params[:user_first]
  	user.user_last = params[:user_last]
  	user.user_email = params[:user_email]
  	#user.terms = params[:terms]  #<<<< Need to resolve test for saving "terms"
  	user.save
  	redirect_to user_path
  end

	def show
		@user = User.find(params[:id])     #Test for this is currently being performed by the feature test using capybara.  Is there a better way to do this.
		render :show
	end	

	def edit
		@existing_user = User.find(params[:id])
		render :edit
	end

	def update
		existing_user = User.find(params[:id])
		existing_user.user_first = params[:user_first]
		existing_user.user_last = params[:user_last]
		existing_user.user_email = params[:user_email]
		existing_user.save!
		redirect_to user_path
	end


end

