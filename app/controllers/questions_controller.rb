# app/controllers/questions_controller.rb
class QuestionsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_quiz, only: [:new, :create]
    before_action :set_question, only: [:destroy, :edit, :update]
    before_action :authorize_user!, only: [:edit, :update, :destroy]

    def index
    end

    def edit
    end

    def update
      if @question.update(question_params)
        redirect_to quiz_url(@question.quiz), notice: "Question was successfully updated."
      else
        render :edit, status: :unprocessable_entity 
      end
    end
  
    def create
      @question = @quiz.questions.new(question_params)
     
      if params[:commit] == "add_answer"
        @question.answers.new
        render :new, status: :unprocessable_entity
      else

      if @question.save
        flash.notice = "Question was successfully created."
        redirect_to quiz_url(@quiz)
      else
        render :new, status: :unprocessable_entity
      end
    end
  end
  
    def new
      @question = @quiz.questions.new
      @question.answers.new
    end
  
    def edit
    end

  def update
      if @question.update(question_params)
      redirect_to quiz_url(@question.quiz), notice: "Quiz was successfully updated."
    else
      render :edit, status: :unprocessable_entity 
    end
  end

    def add_answer
      @question = @quiz.questions.new(question_params)
      @question.answers.new
      render :new
    end
    
    # DELETE /questions/1
    def destroy
      if @question.quiz.user == current_user
        @question.destroy!
        redirect_to quiz_path(@question.quiz), notice: "Question was successfully destroyed."
      else
        redirect_to quiz_path(@question.quiz), notice: "Question was successfully destroyed."
      end
    end
    
    private

    def set_quiz
      @quiz = Quiz.find(params[:quiz_id])
    end
  
    def set_question
      @question = Question.find(params[:id])
    end
  
    def question_params
      params.require(:question).permit(:question_text, :points, answers_attributes: [:id, :answer_text, :correct, :_destroy])
    end
  end