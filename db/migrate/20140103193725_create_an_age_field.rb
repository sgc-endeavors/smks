class CreateAnAgeField < ActiveRecord::Migration
  def up
  	add_column :stories, :people_age, :string 
  end

  def down
  	remove_column :stories, :people_age
  end
end
