class RenameColumns < ActiveRecord::Migration
  def up
  	rename_column :users, :user_first, :first_name
  	rename_column :users, :user_last, :last_name
  	rename_column :users, :user_email, :email
  end


  def down
  	rename_column :users, :first_name, :user_first
  	rename_column :users, :last_name, :user_last
  	rename_column :users, :email, :user_email
  end
end
