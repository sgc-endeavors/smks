class UsersController < ApplicationController
  
  def new
    render :new
  end

  def create
  	user = User.new
  	user.user_first = params[:user_first]
  	user.user_last = params[:user_last]
  	user.user_email = params[:user_email]
  	user.terms = params[:terms]  
  	user.save!
  	redirect_to user_path(user)
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
		if params[:update] 
			existing_user.user_first = params[:user_first]
			existing_user.user_last = params[:user_last]
			existing_user.user_email = params[:user_email]
			existing_user.save!
		end

		redirect_to user_path
	end

	def index
		@existing_users = User.all
		render :index
	end

	def destroy
		destroyed_user = User.find(params[:id])
		destroyed_user.destroy
		redirect_to	users_path

	end






end

