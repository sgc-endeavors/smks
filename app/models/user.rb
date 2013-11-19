class User < ActiveRecord::Base
  attr_accessible :is_admin, :terms, :user_email, :user_first, :user_last
    validates :user_email, presence: true, uniqueness: true
    validates :terms, :acceptance => {:accept => true}
    # This validation for terms is not working
end


#Get rid of user_ for the names to eliminate redundancy; use first_name & last_name
#Consider using admin? vs. is_admin (you get question mark automatically)
#Use pending tests, TODO & stories for circling back