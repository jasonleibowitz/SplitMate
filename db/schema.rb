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

ActiveRecord::Schema.define(version: 20140425195303) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apartments", force: true do |t|
    t.string  "name"
    t.string  "street"
    t.string  "apt"
    t.integer "zipcode"
  end

  create_table "approvals", force: true do |t|
    t.integer "chore_id"
    t.integer "roommate_id"
    t.integer "value"
  end

  create_table "chores", force: true do |t|
    t.string   "name"
    t.integer  "points_value"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "date_completed"
    t.text     "comments"
    t.boolean  "rebuy"
    t.integer  "roommate_id"
    t.integer  "apartment_id"
  end

  create_table "users", force: true do |t|
    t.string  "first_name"
    t.string  "last_name"
    t.string  "email"
    t.integer "points_balance"
    t.integer "points_lifetime"
    t.integer "completed_week_points"
    t.integer "total_week_points"
    t.integer "dollar_balance"
    t.boolean "admin"
    t.string  "password_digest"
    t.integer "apartment_id"
  end

end
