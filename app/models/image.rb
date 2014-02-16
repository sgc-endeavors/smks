class Image < ActiveRecord::Base
  attr_accessible :s3_image_loc, :story_id, :user_id
  belongs_to(:user)
  belongs_to(:story)

  mount_uploader :s3_image_loc, ImageUploader
end
