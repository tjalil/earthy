class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :location_title
      t.string :subtitle
      t.text :photo_credit
      t.text :info_source
      t.text :image_url
      t.string :local_url
      t.text :answer_description
      t.string :choice_1
      t.string :choice_2
      t.string :choice_3
      t.string :choice_4
      t.string :correct_choice

      t.timestamps
    end
  end
end
