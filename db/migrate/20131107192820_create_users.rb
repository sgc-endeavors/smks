class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_email
      t.string :user_first
      t.string :user_last
      t.string :password
      t.boolean :terms
      t.boolean :is_admin

      t.timestamps
    end
  end
end
