class User < ActiveRecord::Base
  attr_accessible :is_admin, :terms, :user_email, :user_first, :user_last
    validates :user_email, presence: true, uniqueness: true
    validates :terms, :acceptance => {:accept => true}
    # This validation for terms is not working
end
