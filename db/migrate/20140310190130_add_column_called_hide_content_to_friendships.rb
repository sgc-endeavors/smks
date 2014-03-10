class AddColumnCalledHideContentToFriendships < ActiveRecord::Migration
  def up
	  add_column :friendships, :hide_content, :boolean
  end

  def down
  	remove_column :friendships, :hide_content
  end
end
