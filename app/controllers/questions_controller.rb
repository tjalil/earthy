class QuestionsController < ApplicationController
  def index

  end

  def ask
    
    @question = Question.random_question

  end

  def validate

    choice = params[:answer]
    question_id = params[:question_id]

    @answer = Question.answer_question(question_id,choice)

  end
end
