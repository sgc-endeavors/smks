class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.integer :user_id
      t.integer :story_id

      t.timestamps
    end
  end
end
