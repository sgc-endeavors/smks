class User < ActiveRecord::Base
  attr_accessible :is_admin, :terms, :email, :first_name, :last_name
    validates :email, presence: true, uniqueness: true
    validates :terms, :acceptance => {:accept => true}
    # NEED TO RESOLVE ISSUES W/ THE ABOVE VALIDATION
    has_many :stories
    
end

