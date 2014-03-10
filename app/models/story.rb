class Story < ActiveRecord::Base
  attr_accessible :approved, :body, :category_id, :picture_id, :title, :user_id, :status, :share_type, :kids_age, :date_occurred
  validates :title, presence: true
  validates :user_id, presence: true
  belongs_to :user
  has_many :ratings, dependent: :destroy
  has_many :remarks, dependent: :destroy
  belongs_to :kid
  has_many :images, dependent: :destroy



  def calculate_story_age
		age = (self.date_occurred - self.kid.birthdate) / 86400
	 		if age < 7
	 			"#{age.round(0)} days"
	 		elsif age < 84
	 			"#{(age / 7).round(0)} weeks"
	 		elsif age < 725
	 			"#{(age / 30.417).round(0)} months"
	 		else
	 			"#{(age / 365).round(0)} years"
	 		end
  end

  

  
end
