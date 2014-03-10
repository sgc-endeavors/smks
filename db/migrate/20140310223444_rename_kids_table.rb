class RenameKidsTable < ActiveRecord::Migration
  def up
  	rename_table :kids, :people
  end

  def down
  	rename_table :people, :kids
  end
end
