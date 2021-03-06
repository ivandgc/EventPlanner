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

ActiveRecord::Schema.define(version: 20170801211922) do

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.time "duration"
    t.integer "occasion_id"
    t.integer "term_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "admin_id"
    t.index ["occasion_id"], name: "index_events_on_occasion_id"
    t.index ["term_id"], name: "index_events_on_term_id"
  end

  create_table "occasions", force: :cascade do |t|
    t.string "title"
    t.integer "term_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "admin_id"
    t.index ["term_id"], name: "index_occasions_on_term_id"
  end

  create_table "terms", force: :cascade do |t|
    t.datetime "start_term"
    t.datetime "end_term"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_events", force: :cascade do |t|
    t.integer "user_occasion_id"
    t.integer "event_id"
    t.index ["event_id"], name: "index_user_events_on_event_id"
    t.index ["user_occasion_id"], name: "index_user_events_on_user_occasion_id"
  end

  create_table "user_occasions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "occasion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["occasion_id"], name: "index_user_occasions_on_occasion_id"
    t.index ["user_id"], name: "index_user_occasions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
