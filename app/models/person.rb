class Person < ActiveRecord::Base
  attr_accessible :name, :story_id, :user_id
  belongs_to :user
  has_many :stories

  def self.create_new_person_at_registration(new_user)
  	new_person = Person.new
  	new_person.name = new_user[:first_name]
    new_person.user_id = User.find_by_email(new_user[:email]).id	
  	new_person.save!
  end






end
