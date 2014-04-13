# Required to serialize cookie data
require "yaml"

class QuestionsController < ApplicationController

  # How many questions per round (default 6, lowered to 1 for testing)
  GAME_LENGTH = 3


  def index

    scores = {:current_round => [], :total_score => 0}
    cookies[:score] = serialize scores
    cookies[:round] = serialize 1
    cookies[:name] = ""

  end

  def ask

    if params[:newround]
      next_round
    end


    counter_passed = params[:counter]

    @counter_passed_array = counter_passed.split("|")

    if cookies[:name].empty?
      @name = params[:name].capitalize
      cookies[:name] = serialize @name 
    else
      @name = deserialize cookies[:name]
    end
    
    @rounds = deserialize cookies[:round]
    

    @round_qs = GAME_LENGTH
    # Time for results page!
    if @counter_passed_array.length > GAME_LENGTH

      # Remove the first empty array
      @counter_passed_array.shift

      score_hash = deserialize cookies[:score]
      @score = score_hash[:current_round]
      @total_score = score_hash[:total_score]
      binding.pry

      @right_answers = @score.select { |s| s == true }.length
      
      if @right_answers == GAME_LENGTH
        @congratulations = "High five, you did great #{@name}!!!"
      elsif @right_answers >= (GAME_LENGTH / 2) and @right_answers < GAME_LENGTH
        @congratulations = "Not bad #{@name}, another round to get better?"
      else
        @congratulations = "Let's play another round, you are getting there #{@name} :-)"
      end

      render :summary

    else
      @question = Question.random_question(@counter_passed_array)

      @choice1 = @question.choice_1.split("|")
      @choice2 = @question.choice_2.split("|")
      @choice3 = @question.choice_3.split("|")
      @choice4 = @question.choice_4.split("|")

      @counter_passed_array << @question.id

      @facts_array = []
      @facts_array << @question.interesting_1

      @counter_to_pass = @counter_passed_array.join("|")
      @question_number = @counter_passed_array.length - 1
    end

  end

  def validate

    @name = params[:player_name]
    @round_qs = GAME_LENGTH
    @rounds = deserialize cookies[:round]


    choice = params[:answer]

    question_id = params[:question_id]

    @counter_to_pass = params[:counter]

    @question = Question.find(question_id)

    @answer = Question.answer_question(question_id,choice)
    update_score_cookie
   

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
    score_hash = deserialize(cookies[:score])
    @score = score_hash[:current_round]
    @score << @answer
    score_hash[:current_round] = @score
    if @answer then score_hash[:total_score] += 1 end
    # binding.pry

    cookies[:score] = serialize score_hash
  end

  def next_round
    score_hash = deserialize(cookies[:score])
    score_hash[:current_round] = []
    cookies[:score] = serialize score_hash
    # binding.pry

    @round = (deserialize cookies[:round]).to_i + 1
    cookies[:round] = serialize @round
  end

end
