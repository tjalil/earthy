# Required to serialize cookie data
require "yaml"

class QuestionsController < ApplicationController

  # How many questions per round 
  GAME_LENGTH = 2

  def index
    @background = "/assets/"+Question.random_question([]).local_url.downcase+".jpg"

    # Our data:
    # Current round     int
    # Round score       int
    # questions         array of hashes > { id: boolean }
    # name              string

    gameObj = {
      name: "",
      round: 1,
      score: 0,
      totalScore: 0,
      questions: []
    }

    cookies[:game] = serialize gameObj

  end

  def ask
    if params[:newround]
      next_round
    end

    gameObj = deserialize cookies[:game]


    if gameObj[:name].empty?
      gameObj[:name] = params[:name].capitalize
    end

    @name = gameObj[:name]


    @counter_passed_array = gameObj[:questions]
    @rounds = gameObj[:round]


    @round_qs = GAME_LENGTH

    # Time for results page!
    if @counter_passed_array.length >= GAME_LENGTH

      @questions_array = gameObj[:questions]
      @score = gameObj[:score]

      @right_answers = @score
      
      determine_congrats_message
      render :summary
    else
      get_new_question
      get_question_choices
     
      @facts_coords = []
      
      get_interesting_facts
      make_fact_node_coords

      cookies[:game] = serialize gameObj

      @question_number = @counter_passed_array.length + 1
    end
  end

  def validate
    gameObj = deserialize cookies[:game]

    @round_qs = GAME_LENGTH
    @rounds = gameObj[:round]


    choice = params[:answer]
    question_id = params[:question_id]

    @answer = Question.answer_question(question_id,choice)
    @question = Question.find(question_id)


    make_submit_button_label

    gameObj[:questions] << { question_id => @answer }
    gameObj[:score] += 1 if @answer

    cookies[:game] = serialize gameObj

    @question_number = gameObj[:questions].length


  end

  def serialize(item)
    YAML::dump item
  end

  def deserialize(item)
    YAML::load item
  end

  def next_round
    gameObj = deserialize cookies[:game]
    
    gameObj[:round] += 1
    gameObj[:totalScore] += gameObj[:score]
    gameObj[:score] = 0
    gameObj[:questions] = []

    cookies[:game] = serialize gameObj
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
