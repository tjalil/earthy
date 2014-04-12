class QuestionsController < ApplicationController

  @counter = []

  def index

  end

  def ask
    

    counter_passed = params[:counter]

    counter_passed_array = counter_passed.split("|")

    if counter_passed_array.length >= 6

      redirect_to end_path

    else

      @question = Question.random_question(counter_passed_array)

      counter_passed_array << @question.id

      @counter_to_pass = counter_passed_array.join("|")

    end

  end

  def validate

    choice = params[:answer]

    question_id = params[:question_id]

    @counter_to_pass = params[:counter]

    @answer = Question.answer_question(question_id,choice)

  end
end
