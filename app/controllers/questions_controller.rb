# Required to serialize cookie data
require "yaml"

class QuestionsController < ApplicationController

  # How many questions per round (default 6, lowered to 1 for testing)
  GAME_LENGTH = 6


  def index
    @background = "/assets/"+Question.random_question([]).local_url.downcase+".jpg"
    puts '-----------------------------'
    puts @background
    puts '-----------------------------'
    cookies[:score] = YAML::dump []
  end

  def ask

    counter_passed = params[:counter]

    @counter_passed_array = counter_passed.split("|")

    @name = params[:name]

    # Time for results page!
    if @counter_passed_array.length > GAME_LENGTH

      # Remove the first empty array
      @counter_passed_array.shift

      @score = YAML::load cookies[:score]

      render :summary

    else
      @question = Question.random_question(@counter_passed_array)

      @choice1 = @question.choice_1.split("|")
      @choice2 = @question.choice_2.split("|")
      @choice3 = @question.choice_3.split("|")
      @choice4 = @question.choice_4.split("|")

      @counter_passed_array << @question.id

      @counter_to_pass = @counter_passed_array.join("|")
      @question_number = @counter_passed_array.length - 1
    end

  end

  def validate

    @name = params[:player_name]

    choice = params[:answer]

    question_id = params[:question_id]

    @counter_to_pass = params[:counter]

    @question = Question.find(question_id)

    @answer = Question.answer_question(question_id,choice)
    @score = YAML::load cookies[:score]
    @score << @answer
    cookies[:score] = YAML::dump @score

    # Uncomment this statement to break and check
    # values of the cookie
    #binding.pry

    @question_number = (@counter_to_pass.split("|")).length - 1
  end

  def summary
    @name = params[:player_name]

  end

end
