class ChangeRelationshipForKidAndStory < ActiveRecord::Migration
  def up
  	remove_column :kids, :story_id
  	add_column :stories, :kid_id, :integer
  end

  def down
  	add_column :kids, :story_id, :integer
  	remove_column :stories, :kid_id
  end
end
