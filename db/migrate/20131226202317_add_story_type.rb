class AddStoryType < ActiveRecord::Migration
  def up
  	add_column :stories, :share_type, :string
  end

  def down
  	remove_column :stories, :share_type
  end
end
