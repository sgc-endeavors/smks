class CreateAnAgeField < ActiveRecord::Migration
  def up
  	add_column :stories, :kids_age, :string 
  end

  def down
  	remove_column :stories, :kids_age
  end
end
