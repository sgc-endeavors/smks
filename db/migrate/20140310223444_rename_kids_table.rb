class RenamePeopleTable < ActiveRecord::Migration
  def up
  	rename_table :people, :people
  end

  def down
  	rename_talbe :people, :people
  end
end
