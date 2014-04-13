# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140413151936) do

  create_table "questions", force: true do |t|
    t.string   "location_title"
    t.text     "interesting_1"
    t.text     "interesting_2"
    t.text     "interesting_3"
    t.string   "subtitle"
    t.text     "photo_credit"
    t.text     "info_source"
    t.text     "image_url"
    t.string   "local_url"
    t.text     "answer_description"
    t.string   "choice_1"
    t.string   "choice_2"
    t.string   "choice_3"
    t.string   "choice_4"
    t.string   "correct_choice"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
