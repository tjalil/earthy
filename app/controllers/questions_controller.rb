class QuestionsController < ApplicationController
  def index

  end
  def ask
    @name = params[:name]
    @question = Question.find(1)
    puts "\n\n\n\n\nTHIS IS IT:\n"
    puts @question.inspect
    puts "\n\n\n\n\n"
  end

  def validate
    
  end
end
