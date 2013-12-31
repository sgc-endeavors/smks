class ReviseStatusNamingConvention < ActiveRecord::Migration
  def up
  	remove_column :stories, :status_id
  	add_column :stories, :status, :string
  end

  def down
  	add_column :stories, :status_id, :integer
  	remove_column :stories, :status
  end
end
