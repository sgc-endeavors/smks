class Person < ActiveRecord::Base
  attr_accessible :name, :story_id, :user_id
  belongs_to :user
  has_many :stories
end
