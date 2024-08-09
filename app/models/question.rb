class Question < ApplicationRecord
    validates :question_text, presence: true
  
    belongs_to :quiz
    has_many :answers, dependent: :destroy

    accepts_nested_attributes_for :answers, allow_destroy: true,

    private

    def validate_answers
      errors.add(:answers, :too_few, message: "at least two answers needed") if answers.count <2
      errors.add(:answers, :no_correct, message: "at least one correct answer needed") if answers.none? { |ans| ans.correct? }
  end
