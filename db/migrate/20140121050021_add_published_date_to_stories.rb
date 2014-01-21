class AddPublishedDateToStories < ActiveRecord::Migration
  def change
  	add_column :stories, :published_date, :datetime
  end
end
