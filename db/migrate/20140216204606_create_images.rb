class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :s3_image_loc
      t.integer :user_id
      t.integer :story_id

      t.timestamps
    end
  end
end
