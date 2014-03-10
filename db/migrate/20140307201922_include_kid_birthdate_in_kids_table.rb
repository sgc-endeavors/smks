class IncludePersonBirthdateInPeopleTable < ActiveRecord::Migration
  def up
	  add_column :people, :birthdate, :datetime
  end

  def down
  	remove_column :people, :birthdate
  end
end
