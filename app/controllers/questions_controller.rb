class QuestionsController < ApplicationController
  def index

  end
  def ask
    @question = Question.new
  end

  def validate
    
  end
end
