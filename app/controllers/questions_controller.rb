class QuestionsController < ApplicationController
  def index
  end

  def ask
    @question = Question.new
  end

  def validate
  	@answer = Question.answer_question(params[:id],params[:choice])
  	if @answer == true
  		redirect_to 'questions#validate'
  	else
  		redirect_to #what?
  end
end
