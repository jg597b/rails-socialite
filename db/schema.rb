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

ActiveRecord::Schema.define(version: 20180225051113) do

  create_table "events", force: :cascade do |t|
    t.integer "host_id", null: false
    t.string "event_name", limit: 255, null: false
    t.text "description", limit: 255
    t.datetime "event_start", null: false
    t.datetime "event_end", null: false
    t.integer "capacity", null: false
    t.datetime "rsvp_start", null: false
    t.datetime "rsvp_end", null: false
    t.integer "event_type", limit: 1, null: false
    t.string "venue_addr1", limit: 255, null: false
    t.string "venue_addr2", limit: 255
    t.string "venue_city", limit: 255, null: false
    t.string "venue_state", limit: 255, null: false
    t.string "venue_zip", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["host_id"], name: "index_events_on_host_id"
  end

  create_table "hosts", force: :cascade do |t|
    t.string "business_name", limit: 255, null: false
    t.string "email_addr", limit: 255, null: false
    t.string "passwd", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invitations", force: :cascade do |t|
    t.integer "attended_event_id"
    t.integer "user_id"
    t.boolean "accepted", default: false
    t.integer "guest_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_invitations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", limit: 255, null: false
    t.string "last_name", limit: 255, null: false
    t.string "email_addr", limit: 255, null: false
    t.string "passwd", limit: 64, null: false
    t.string "phone", limit: 255, null: false
    t.string "addr1", limit: 255
    t.string "addr2", limit: 255
    t.string "city", limit: 255
    t.string "state", limit: 255
    t.string "zip", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
