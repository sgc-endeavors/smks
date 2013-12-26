class AddSharePreferenceType < ActiveRecord::Migration
  def up
  add_column :users, :default_share_preference, :string
  end

  def down
  remove_column :users, :default_share_preference
  end
end
