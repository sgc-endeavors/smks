class Story < ActiveRecord::Base
  attr_accessible :approved, :body, :category_id, :picture_id, :title, :user_id, :status, :share_type, :kids_age
  validates :title, presence: true
  validates :user_id, presence: true
  belongs_to :user
  has_many :ratings
  has_many :comments
  belongs_to :kid

end
