class AddDateOccurredToStory < ActiveRecord::Migration
 def up
  	add_column :stories, :date_occurred, :datetime
  end

  def down
  	remove_column :stories, :date_occurred
  end
end
