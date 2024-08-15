# app/controllers/quizzes_controller.rb
class QuizzesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  # other actions...

  before_action :set_quiz, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  # GET /quizzes or /quizzes.json
  def index
    @quizzes = Quiz.all

    @title = 'These are the quizzes:'
  end

  def start
    @quiz = Quiz.find(params[:quiz_id])
    @title = 'Start some quiz'


    respond_to do |format|
      format.html
      format.json do
        render json: { title: @title, description: "Šī ir json atbilde" }
      end
    end
  end

  # GET /quizzes/1 or /quizzes/1.json
  def show
  end

  # GET /quizzes/new
  def new
    @quiz = Quiz.new
  end

  # GET /quizzes/1/edit
  def edit
  end

  def take
    right_answers = 0
    total_points = 0
    answers = params[:answers]
    points = params[:points]
    @quiz = Quiz.find(params[:quiz_id])
    answers = params[:answers] || {}  # Handle case when no answers are submitted
    
    unanswered_questions = []
    @quiz.questions.each do |question|
      if answers[question.id.to_s].blank?
        unanswered_questions << question
      end
    end

    answers.keys.each do |question_id|
      answer_id = answers[question_id].to_i
      question = Question.find question_id
      right_answer_id = question.answers.where(correct: true).first.id
      # question.points
      if answer_id == right_answer_id
        right_answers = right_answers + 1
        total_points = total_points + question.points
      end
    end

    if unanswered_questions.any?
      # If there are unanswered questions, show a warning message
      flash[:alert] = "Please answer all questions before submitting."
      redirect_to start_quiz_path(@quiz) and return
    end

    redirect_to result_quizzes_path(right_answers: right_answers, total_points: total_points)
  end


  def result 
    @right_answer = params[:right_answers]
    @total_points = params[:total_points]
  end

  # POST /quizzes or /quizzes.json
  def create
    @quiz = Quiz.new(quiz_params)

    respond_to do |format|
      if @quiz.save
        format.html do
          flash.notice = "Quiz was successfully created this time."
          redirect_to quiz_url(@quiz)
        end
        format.json { render :show, status: :created, location: @quiz }
      else
        flash.now.alert = 'Something went wrong'
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quizzes/1 or /quizzes/1.json
  def update
    respond_to do |format|
      if @quiz.update(quiz_params)
        format.html { redirect_to quiz_url(@quiz), notice: "Quiz was successfully updated." }
        format.json { render :show, status: :ok, location: @quiz }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quizzes/1 or /quizzes/1.json
  def destroy
    if @quiz.user == current_user
      @quiz.destroy!
      respond_to do |format|
        format.html { redirect_to quizzes_url, notice: "Quiz was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      redirect_to quizzes_url, alert: 'You are not authorized to delete this quiz.'
    end
  end

  private
  
  # Use callbacks to share common setup or constraints between actions.
  def set_quiz
    @quiz = Quiz.find(params[:id])
  end

  def authorize_user!
    unless @quiz.user == current_user
      redirect_to quizzes_path, alert: 'You are not authorized to edit or delete this quiz.'
    end
  end

  # Only allow a list of trusted parameters through.
  def quiz_params
    params.require(:quiz).permit(:title, :description)
  end
end