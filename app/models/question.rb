class Question < ActiveRecord::Base

  def self.random_question(questions_administered)
    max_id = Question.maximum(:id)
    min_id = Question.minimum(:id)

    while true do 
      random_q_id = Random.new.rand(min_id..max_id)
      break if Question.exists?(random_q_id) && !questions_administered.include?(random_q_id.to_s) && Question.find(random_q_id).interesting_1 != "" && Question.find(random_q_id).interesting_2 != ""
    end

    @current_question = Question.find(random_q_id)  #captured in an instance variable so that it can be used by the evaluate_question method
  end 

  def self.answer_question(q_id,choice)
    question = Question.find(q_id)
    choice.to_s == question.correct_choice.to_s
  end 

end
