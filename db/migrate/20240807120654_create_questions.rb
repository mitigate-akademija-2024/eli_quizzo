# db/migrate/20240807120654_create_questions.rb
class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.string :question_text, null: false
      t.timestamps
    end

    add_reference :questions, :quiz, foreign_key: true
  end
end
