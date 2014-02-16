class RemoveImageColumn < ActiveRecord::Migration
  def up
  	remove_column :stories, :image
  end

  def down
  	add_column :stories, :image, :string
  end
end
