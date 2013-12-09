class Rating < ActiveRecord::Base
  attr_accessible :name, :story_id, :user_id
  belongs_to :user
  belongs_to :story
end
