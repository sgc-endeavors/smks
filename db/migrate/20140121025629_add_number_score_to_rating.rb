class AddNumberScoreToRating < ActiveRecord::Migration
  def change
  	add_column :ratings, :numeric_score, :integer
  end
end
