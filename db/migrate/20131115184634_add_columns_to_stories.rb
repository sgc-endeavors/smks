class AddColumnsToStories < ActiveRecord::Migration
  def up
  	add_column :stories, :status_id, :integer
  end

	def down
  	remove_column :stories, :status_id
  end

end
