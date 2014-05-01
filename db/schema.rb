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

ActiveRecord::Schema.define(version: 20140501214007) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apartments", force: true do |t|
    t.string   "name"
    t.string   "street"
    t.string   "apt"
    t.string   "zipcode"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "default_avatar"
    t.float    "latitute"
    t.float    "longitude"
    t.string   "chore_assignment_day"
  end

  create_table "approvals", force: true do |t|
    t.integer "chore_history_id"
    t.integer "user_id"
    t.integer "value"
  end

  create_table "chore_histories", force: true do |t|
    t.string   "name"
    t.integer  "points_value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "comments"
    t.integer  "user_id"
    t.integer  "apartment_id"
    t.integer  "approval_points"
    t.integer  "approval_ratio"
    t.integer  "chore_id"
    t.boolean  "approved"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "after_picture_file_name"
    t.string   "after_picture_content_type"
    t.integer  "after_picture_file_size"
    t.datetime "after_picture_updated_at"
    t.integer  "js_date"
  end

  add_index "chore_histories", ["chore_id"], name: "index_chore_histories_on_chore_id", using: :btree

  create_table "chores", force: true do |t|
    t.string   "name"
    t.integer  "points_value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "apartment_id"
    t.string   "due_date"
    t.date     "current_due_date"
    t.integer  "dollar_value"
    t.date     "current_assigned_date"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "points_balance"
    t.integer  "points_lifetime"
    t.integer  "completed_week_points"
    t.integer  "total_week_points"
    t.integer  "dollar_balance"
    t.boolean  "admin"
    t.string   "password_digest"
    t.integer  "apartment_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "default_avatar"
    t.boolean  "vacation"
  end

end
