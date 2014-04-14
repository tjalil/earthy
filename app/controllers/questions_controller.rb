# Required to serialize cookie data
require "yaml"

class QuestionsController < ApplicationController

  # How many questions per round 
  GAME_LENGTH = 6

  def index
    @background = "/assets/"+Question.random_question([]).local_url.downcase+".jpg"

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

      score_data = deserialize cookies[:score]
      @score = score_data[:current_round]
      @total_score = score_data[:total_score]

      @right_answers = @score.select { |s| s == true }.length
      
      determine_congrats_message
      render :summary
    else
      get_new_question
      get_question_choices
     
      @counter_passed_array << @question.id
      @facts_coords = []
      
      get_interesting_facts
      make_fact_node_coords

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

    make_submit_button_label
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

    cookies[:score] = serialize score_hash
  end

  def next_round
    score_hash = deserialize(cookies[:score])
    score_hash[:current_round] = []
    cookies[:score] = serialize score_hash

    @round = (deserialize cookies[:round]).to_i + 1
    cookies[:round] = serialize @round
  end

  def get_new_question
    @question = Question.random_question(@counter_passed_array)
  end

  def get_question_choices
    @choice1 = @question.choice_1.split("|")
    @choice2 = @question.choice_2.split("|")
    @choice3 = @question.choice_3.split("|")
    @choice4 = @question.choice_4.split("|")
  end

  def get_interesting_facts
    @facts_array = []
    @facts_array << @question.interesting_1 unless @question.interesting_1.empty?
    @facts_array << @question.interesting_2 unless @question.interesting_2.empty?
    @facts_array << @question.interesting_3 unless @question.interesting_3.empty?
  end

  def make_fact_node_coords
    @facts_array.each { @facts_coords << [rand(10..80), rand(5..70)] }
    # end
  end

  def determine_congrats_message
    if @right_answers == GAME_LENGTH
      @congratulations = "High five, you did great #{@name}!!!"
    elsif @right_answers >= (GAME_LENGTH / 2) and @right_answers < GAME_LENGTH
      @congratulations = "Not bad #{@name}, another round to get better?"
    else
      @congratulations = "Let's play another round, you are getting there #{@name} :-)"
    end
  end

  def make_submit_button_label
    @submit_text = "View Summary" if @question_number == GAME_LENGTH
    @submit_text ||= "Next Question"
  end
end
