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

ActiveRecord::Schema.define(version: 20160205064407) do

  create_table "answers", force: :cascade do |t|
    t.string   "content"
    t.boolean  "correct_answer"
    t.integer  "question_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id"

  create_table "exams", force: :cascade do |t|
    t.integer  "status"
    t.integer  "duration",        default: 20
    t.integer  "number_question", default: 30
    t.integer  "user_id"
    t.integer  "subject_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "time_start"
    t.integer  "time_end"
  end

  add_index "exams", ["subject_id"], name: "index_exams_on_subject_id"
  add_index "exams", ["user_id"], name: "index_exams_on_user_id"

  create_table "questions", force: :cascade do |t|
    t.string   "content"
    t.integer  "question_type"
    t.integer  "subject_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "status",        default: 0
    t.integer  "user_id"
  end

  add_index "questions", ["subject_id"], name: "index_questions_on_subject_id"

  create_table "results", force: :cascade do |t|
    t.integer  "spent_time"
    t.integer  "user_id"
    t.integer  "exam_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "results", ["exam_id"], name: "index_results_on_exam_id"
  add_index "results", ["question_id"], name: "index_results_on_question_id"
  add_index "results", ["user_id"], name: "index_results_on_user_id"

  create_table "subjects", force: :cascade do |t|
    t.string   "content"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",               default: "", null: false
    t.string   "encrypted_password",  default: "", null: false
    t.string   "name",                default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "role",                default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
