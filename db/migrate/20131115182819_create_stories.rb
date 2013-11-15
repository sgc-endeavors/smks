class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.text :body
      t.boolean :approved
      t.integer :user_id
      t.integer :category_id
      t.integer :picture_id

      t.timestamps
    end
  end
end
