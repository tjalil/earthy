# Required to serialize cookie data
require "yaml"

class QuestionsController < ApplicationController

  # How many questions per round (default 6, lowered to 1 for testing)
  GAME_LENGTH = 1


  def index
    cookies[:score] = serialize []
    cookies[:round] = serialize 1
  end

  def ask


    counter_passed = params[:counter]

    @counter_passed_array = counter_passed.split("|")

    @name = params[:name].capitalize
    @round_qs = GAME_LENGTH
    # Time for results page!
    if @counter_passed_array.length > GAME_LENGTH

      # Remove the first empty array
      @counter_passed_array.shift

      @score = deserialize cookies[:score]
      @rounds = deserialize cookies[:round]

      print "\n\n\nSCORE IS:\n\n#{@score}\n\n\n\n\n"

      @right_answers = @score.select { |s| s == true }.length

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
    @round_qs = GAME_LENGTH


    choice = params[:answer]

    question_id = params[:question_id]

    @counter_to_pass = params[:counter]

    @question = Question.find(question_id)

    @answer = Question.answer_question(question_id,choice)
    update_score_cookie
   

    # Uncomment this statement to break and check
    # values of the cookie
    #binding.pry

    @question_number = (@counter_to_pass.split("|")).length - 1

    @submit_text = "View Summary" if @question_number == GAME_LENGTH
    @submit_text ||= "Next Question"

  end

  def serialize(item)
    YAML::dump item
  end

  def deserialize(item)
    YAML::load item
  end

  def update_score_cookie
    @score = deserialize(cookies[:score])
    @score << @answer
    cookies[:score] = serialize(@score)
  end

  def reset_game
    cookies[:score] = serialize []

    @round = (deserialize cookies[:round]).to_i + 1
    cookies[:round] = serialize @round

    redirect_to :ask
  end



end
