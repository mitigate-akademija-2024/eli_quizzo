# db/migrate/20240807081256_create_quizzes.rb
class CreateQuizzes < ActiveRecord::Migration[7.1]
  def change
    create_table :quizzes do |t|
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end