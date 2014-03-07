class IncludeKidBirthdateInKidsTable < ActiveRecord::Migration
  def up
	  add_column :kids, :birthdate, :datetime
  end

  def down
  	remove_column :kids, :birthdate
  end
end
