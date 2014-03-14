class AddShowOnHomepageToImages < ActiveRecord::Migration
  def up
  	add_column :images, :show_on_homepage, :boolean
  end

  def down
  	remove_column :images, :show_on_homepage
  end
end
