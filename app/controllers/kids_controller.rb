class KidsController < ApplicationController

before_filter :authenticate_user!

def index
	

	@kids = current_user.kids
	@story = Story.first
	render :index
end

def new
@kid = Kid.new
render :new
end

def edit
	@kid = Kid.find(params[:id])
	render :edit
end

def update
	kid = Kid.find(params[:id])
	kid.name = params[:kid][:name]
	kid.birthdate = params[:birthdate]
	kid.save!
	redirect_to kids_path
end

def create
kid = Kid.new(params[:kid])
kid.user_id = current_user.id
kid.birthdate = params[:birthdate]
kid.save!
redirect_to kids_path
end


end
