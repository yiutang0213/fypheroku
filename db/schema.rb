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

ActiveRecord::Schema.define(version: 20180228081325) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "evsockets", force: :cascade do |t|
    t.string "evsocket_code"
    t.boolean "evsocket_status"
    t.integer "evsocket_type"
    t.integer "venue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "parkingspace_evsocketships", force: :cascade do |t|
    t.integer "evsocket_id"
    t.integer "parkingspace_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "parkingspaces", force: :cascade do |t|
    t.integer "venue_id"
    t.string "parkingspace_no"
    t.boolean "parkingspace_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "venues", force: :cascade do |t|
    t.string "name"
    t.text "address"
    t.float "charger_fee"
    t.float "parking_fee"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
