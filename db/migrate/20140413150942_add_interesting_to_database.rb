class AddInterestingToDatabase < ActiveRecord::Migration
  def change

    drop_table :questions

    create_table :questions do |t|
        
      t.string :location_title
      t.text :interesting_1
      t.text :interesting_2
      t.text :interesting_3      
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
