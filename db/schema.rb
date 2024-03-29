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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121030055316) do

  create_table "day_words", :force => true do |t|
    t.integer  "word_id"
    t.integer  "day"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "day_words", ["day"], :name => "index_day_words_on_day", :unique => true

  create_table "posts", :force => true do |t|
    t.string   "lemma"
    t.text     "definition"
    t.boolean  "high_frequency"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "user_words", :force => true do |t|
    t.integer  "user_id"
    t.integer  "word_id"
    t.integer  "score"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_words", ["user_id"], :name => "index_user_words_on_user_id"
  add_index "user_words", ["word_id"], :name => "index_user_words_on_word_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "encrypted_password"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

  create_table "words", :force => true do |t|
    t.string   "lemma"
    t.text     "definition"
    t.boolean  "high_frequency"
    t.text     "images"
    t.integer  "wordnet_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "synonyms"
  end

  add_index "words", ["lemma"], :name => "index_words_on_lemma", :unique => true

end
