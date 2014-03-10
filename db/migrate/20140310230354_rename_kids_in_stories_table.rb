class RenameKidsInStoriesTable < ActiveRecord::Migration
  def up
  	rename_column :stories, :kid_id, :person_id
  end

  def down
  	rename_column :stories, :person_id, :kid_id
  end
end
