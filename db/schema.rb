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

ActiveRecord::Schema.define(version: 20160229081922) do

  create_table "applications", force: true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "verified",       default: true
    t.boolean  "attended",       default: false
    t.integer  "pickup_site_id"
  end

  create_table "assignments", force: true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "zone_id"
  end

  create_table "managements", force: true do |t|
    t.integer  "nursing_home_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.integer  "sender_id",              null: false
    t.integer  "user_id",                null: false
    t.text     "content",                null: false
    t.integer  "status",     default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nurses", force: true do |t|
    t.string   "name"
    t.date     "birthday"
    t.boolean  "gender"
    t.string   "phone"
    t.string   "hometown"
    t.string   "home"
    t.integer  "education"
    t.string   "previous_job"
    t.string   "religion"
    t.string   "interests"
    t.text     "background"
    t.text     "nursing"
    t.integer  "nursing_home_id"
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

  create_table "nursings", force: true do |t|
    t.integer  "nurse_id"
    t.integer  "resident_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pickup_sites", force: true do |t|
    t.string   "name"
    t.integer  "project_id"
    t.string   "liaison"
    t.string   "phone_number"
    t.datetime "meeting_time"
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

  create_table "records", force: true do |t|
    t.integer  "user_id"
    t.integer  "resident_id"
    t.integer  "project_id"
    t.text     "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "eye"
    t.string   "ear"
    t.string   "nose"
    t.string   "tongue"
    t.string   "body"
    t.string   "mind"
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
    t.string   "religion"
    t.integer  "nursing_type"
    t.string   "mental_state"
    t.string   "interests"
    t.string   "tastes"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "ethnic"
    t.integer  "education"
    t.string   "previous_job"
    t.string   "characters"
    t.string   "remark"
  end

  create_table "rooms", force: true do |t|
    t.string   "room_number"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "zone_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",               default: "",    null: false
    t.string   "password",            default: "",    null: false
    t.string   "name"
    t.string   "phone_number"
    t.boolean  "gender",              default: false
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
    t.date     "birthday"
  end

  create_table "zones", force: true do |t|
    t.string   "name"
    t.integer  "nursing_home_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
