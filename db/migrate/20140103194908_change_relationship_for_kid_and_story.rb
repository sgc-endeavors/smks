class ChangeRelationshipForPersonAndStory < ActiveRecord::Migration
  def up
  	remove_column :people, :story_id
  	add_column :stories, :kid_id, :integer
  end

  def down
  	add_column :people, :story_id, :integer
  	remove_column :stories, :kid_id
  end
end
