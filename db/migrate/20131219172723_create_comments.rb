class CreateRemarks < ActiveRecord::Migration
  def change
    create_table :remarks do |t|
      t.text :body
      t.boolean :approved
      t.integer :story_id
      t.integer :user_id

      t.timestamps
    end
  end
end
