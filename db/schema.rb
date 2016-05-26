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

ActiveRecord::Schema.define(version: 20160525000215) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "meetups", force: :cascade do |t|
    t.string   "remote_id",       null: false
    t.string   "event_url",       null: false
    t.text     "description"
    t.text     "how_to_find_us"
    t.datetime "time"
    t.string   "name",            null: false
    t.string   "venue_name"
    t.string   "venue_address_1"
    t.string   "venue_address_2"
    t.string   "venue_city"
    t.string   "venue_state"
    t.string   "venue_zip"
    t.float    "venue_lon"
    t.float    "venue_lat"
    t.datetime "created_at"
  end

end
