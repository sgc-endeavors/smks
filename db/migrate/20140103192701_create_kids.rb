class CreateKids < ActiveRecord::Migration
  def change
    create_table :kids do |t|
      t.string :name
      t.integer :user_id
      t.integer :story_id

      t.timestamps
    end
  end
end
