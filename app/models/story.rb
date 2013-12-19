class Story < ActiveRecord::Base
  attr_accessible :approved, :body, :category_id, :picture_id, :title, :user_id
  validates :title, presence: true
  validates :user_id, presence: true
  belongs_to :user
  has_many :ratings
  has_many :comments

end
