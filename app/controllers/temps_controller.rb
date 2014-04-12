# TEMPORARY CONTROLLER: Doing this temporarily until a real model exists

class Question
  attr_accessor :choice_1, :choice_2, :choice_3, :choice_4
end




class TempsController < ApplicationController

  def index
    @question = Question.new

    @question.choice_1 = ["City 1", "Country 1"]
    @question.choice_2 = ["City 2", "Country 2"]
    @question.choice_3 = ["City 3", "Country 3"]
    @question.choice_4 = ["City 4", "Country 4"]  

    "Lake Whatever|India"

    ["lake whatever", "India"]

  end
end

