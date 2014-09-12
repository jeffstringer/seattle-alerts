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

ActiveRecord::Schema.define(version: 20140912014546) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", force: true do |t|
    t.string   "email"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fire_alerts", force: true do |t|
    t.string   "address"
    t.string   "datetime"
    t.string   "incident_number"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "fire_type"
    t.datetime "time_show"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "police_alerts", force: true do |t|
    t.string   "hundred_block_location"
    t.string   "event_clearance_description"
    t.string   "event_clearance_date"
    t.string   "general_offense_number"
    t.string   "census_tract"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "time_show"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscribers", force: true do |t|
    t.string   "email"
    t.string   "street"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "remember_token"
    t.float    "radius"
  end

  add_index "subscribers", ["email"], name: "index_subscribers_on_email", unique: true, using: :btree
  add_index "subscribers", ["remember_token"], name: "index_subscribers_on_remember_token", using: :btree

end
