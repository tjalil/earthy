class QuestionsController < ApplicationController
  def index

  end

  def ask
    @name = params[:name]

    @question = Question.random_question
    @choice1 = @question.choice_1.split("|")
    @choice2 = @question.choice_2.split("|")
    @choice3 = @question.choice_3.split("|")
    @choice4 = @question.choice_4.split("|")
  end

  def validate

    choice = params[:answer]
    question_id = params[:question_id]

    @question = Question.find(question_id)

    @answer = Question.answer_question(question_id,choice)

    puts "\n\n\n\n\nANSWER IS:\n\n #{@answer.class}\n\n\n\n\n"

  end

end
