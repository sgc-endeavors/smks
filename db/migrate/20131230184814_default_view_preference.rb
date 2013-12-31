class DefaultViewPreference < ActiveRecord::Migration
  def up
  add_column :users, :default_view_preference, :string
  end

  def down
  remove_column :users, :default_view_preference
  end
end