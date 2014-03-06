class Story < ActiveRecord::Base
  attr_accessible :approved, :body, :category_id, :picture_id, :title, :user_id, :status, :share_type, :kids_age, :date_occurred
  validates :title, presence: true
  validates :user_id, presence: true
  belongs_to :user
  has_many :ratings, dependent: :destroy
  has_many :remarks, dependent: :destroy
  belongs_to :kid
  has_many :images, dependent: :destroy

  
end
