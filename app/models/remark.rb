class Remark < ActiveRecord::Base
  attr_accessible :approved, :body, :story_id, :user_id
  belongs_to :story
  belongs_to :user
end
