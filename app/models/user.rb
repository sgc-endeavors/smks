class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :is_admin, :terms, :first_name, :last_name, :default_share_preference
    #validates :email, presence: true, uniqueness: true >> this should be taken care of by DEVISE
    validates :terms, :acceptance => {:accept => true}
    #NEED TO RESOLVE ISSUES W/ THE ABOVE VALIDATION
    
    has_many :stories
    has_many :ratings
    has_many :comments
    
end

