class AddViewedToRemark < ActiveRecord::Migration
  def up
  	add_column :remarks, :viewed, :boolean
  end

  def down
  	remove_column :remarks, :viewed
  end
end
