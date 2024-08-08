class QuestionsController < ApplicationController
    def index
    end

    def create
    end

    def new
        @quiz = Quiz.find(params[:quiz_id])
        @question = @quiz.questions.new
    end
end
