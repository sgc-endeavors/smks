class PeopleController < ApplicationController

before_filter :authenticate_user!

def index
	

	@people = current_user.people
	@story = Story.first
	render :index
end

def new
@person = Person.new
render :new
end

def edit
	@person = Person.find(params[:id])
	render :edit
end

def update
	person = Person.find(params[:id])
	person.name = params[:person][:name]
	person.birthdate = params[:birthdate]
	person.save!
	redirect_to people_path
end

def create
person = Person.new(params[:person])
person.user_id = current_user.id
person.birthdate = params[:birthdate]
person.save!
redirect_to people_path
end


end
