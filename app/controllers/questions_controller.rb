class QuestionsController < ApplicationController
  def index

  end
  def ask
    @name = params[:name]

    @question = Question.first
    @choice1 = @question.choice_1.split("|")
    @choice2 = @question.choice_2.split("|")
    @choice3 = @question.choice_3.split("|")
    @choice4 = @question.choice_4.split("|")
  end

  def validate
    
  end

end
