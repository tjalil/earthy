class Question < ActiveRecord::Base


 def random_question

        if  @questions_administered.length < 6          

            max_id = Question.maximum(:id)
            min_id = Question.minimum(:id)


            while true do                   #keep choosing random IDs until the question exists AND it has not been given already

                random_q_id = Random.new.rand(min_id..max_id)
                break if Question.exists?(random_q_id) # && !@questions_administered.include?(random_q_id)

            end

            @questions_administered << random_q_id

            @current_question = Question.find(random_q_id)  #captured in an instance variable so that it can be used by the evaluate_question method

            @current_question

        else

            # self.initialize
            false

        end
        

    end 



# Need to code 2 methods in here:
#1. pull_question_array -- returns array with 6 ids
#2. fetch_question -- takes 1st element of ids and return question object assoc w/ it

end
