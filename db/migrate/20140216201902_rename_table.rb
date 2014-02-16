class RenameTable < ActiveRecord::Migration
  def up
  rename_table :comments, :remarks
  end

  def down
  	rename_talbe :remarks, :comments
  end
end
