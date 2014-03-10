class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :is_admin, :terms, :first_name, :last_name, :default_share_preference, :default_view_preference
    #validates :email, presence: true, uniqueness: true >> this should be taken care of by DEVISE
    validates :terms, :acceptance => {:accept => true}
    #NEED TO RESOLVE ISSUES W/ THE ABOVE VALIDATION
    
    has_many :stories, dependent: :destroy
    has_many :ratings
    has_many :remarks
    has_many :people, dependent: :destroy
    has_many :images
    has_many :friendships, dependent: :destroy
    has_many :friends, through: :friendships
    has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"#dependent: :destroy
    has_many :inverse_friends, through: :inverse_friendships, source: :user

    
end

