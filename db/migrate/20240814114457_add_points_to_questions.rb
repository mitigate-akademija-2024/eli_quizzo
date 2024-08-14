class AddPointsToQuestions < ActiveRecord::Migration[7.1]
  def change
    add_column :questions, :points, :integer, default: 1
  end
end
