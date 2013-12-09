class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.string :name
      t.integer :user_id
      t.integer :story_id

      t.timestamps
    end
  end
end
