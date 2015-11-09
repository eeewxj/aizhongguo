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

ActiveRecord::Schema.define(version: 20151109052255) do

  create_table "applications", force: true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "verified",   default: false
    t.boolean  "attended",   default: false
  end

  create_table "managements", force: true do |t|
    t.integer  "nursing_home_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nursing_homes", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "contact"
    t.string   "phone_number"
    t.text     "description"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string   "name"
    t.integer  "nursing_home_id"
    t.text     "description"
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "staff_number"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "residents", force: true do |t|
    t.string   "name"
    t.boolean  "gender"
    t.date     "birthday"
    t.text     "condition"
    t.string   "phone_number"
    t.string   "contact"
    t.string   "contact_phone_number"
    t.integer  "room_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rooms", force: true do |t|
    t.string   "room_number"
    t.text     "description"
    t.integer  "nursing_home_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",               default: "", null: false
    t.string   "password",            default: "", null: false
    t.string   "name"
    t.string   "phone_number"
    t.boolean  "gender"
    t.integer  "age"
    t.string   "address"
    t.string   "work_unit"
    t.text     "self_description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "user_type",           default: 2
  end

end
