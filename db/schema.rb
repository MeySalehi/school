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

ActiveRecord::Schema.define(version: 20150829062425) do

  create_table "classrooms", force: :cascade do |t|
    t.string   "name"
    t.integer  "teacher_id",   null: false
    t.string   "courses_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "classrooms", ["teacher_id"], name: "index_classrooms_on_teacher_id"

  create_table "exam_results", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "exam_id"
    t.integer  "result"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "exam_results", ["exam_id"], name: "index_exam_results_on_exam_id"
  add_index "exam_results", ["student_id"], name: "index_exam_results_on_student_id"

  create_table "exams", force: :cascade do |t|
    t.string   "title",        null: false
    t.date     "exam_date"
    t.integer  "score_range"
    t.string   "course_name"
    t.text     "description"
    t.integer  "classroom_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "exams", ["classroom_id"], name: "index_exams_on_classroom_id"

  create_table "options", force: :cascade do |t|
    t.string   "namespace"
    t.string   "title"
    t.string   "value"
    t.string   "default"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.integer  "classroom_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_name"
    t.string   "id_number"
    t.string   "address"
    t.text     "description"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "phone"
    t.string   "birth_date"
  end

  add_index "students", ["classroom_id"], name: "index_students_on_classroom_id"

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "access_level"
    t.string   "role"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

end
