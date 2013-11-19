class UsersController < ApplicationController
  
  def new
    render :new
  end

  def create
  	#user = User.new(params[:user])
  	user = User.new
  	user.first_name = params[:first_name]
  	user.last_name = params[:last_name]
  	user.email = params[:email]
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
		#get rid of if after we modify buttons in edit.html.erb
		
			existing_user.first_name = params[:user][:first_name]
			existing_user.last_name = params[:user][:last_name]
			existing_user.email = params[:email]
			existing_user.save!
		
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

