# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_03_05_085402) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "aeroplane_classes", force: :cascade do |t|
    t.string "category"
    t.integer "rows_number"
    t.integer "seats_per_row"
    t.decimal "seat_price"
    t.integer "position"
    t.integer "total_seats"
    t.bigint "aeroplane_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aeroplane_id"], name: "index_aeroplane_classes_on_aeroplane_id"
  end

  create_table "aeroplanes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "flight_classes", force: :cascade do |t|
    t.decimal "seat_price"
    t.bigint "aeroplane_class_id"
    t.bigint "flight_id"
    t.bigint "aeroplane_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aeroplane_class_id"], name: "index_flight_classes_on_aeroplane_class_id"
    t.index ["aeroplane_id"], name: "index_flight_classes_on_aeroplane_id"
    t.index ["flight_id"], name: "index_flight_classes_on_flight_id"
  end

  create_table "flight_reservations", force: :cascade do |t|
    t.string "user_name"
    t.string "pnr"
    t.bigint "flight_id"
    t.bigint "flight_seat_id"
    t.bigint "flight_class_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flight_class_id"], name: "index_flight_reservations_on_flight_class_id"
    t.index ["flight_id"], name: "index_flight_reservations_on_flight_id"
    t.index ["flight_seat_id"], name: "index_flight_reservations_on_flight_seat_id"
  end

  create_table "flight_seats", force: :cascade do |t|
    t.bigint "flight_class_id"
    t.bigint "flight_id"
    t.boolean "availability"
    t.string "name"
    t.integer "position"
    t.integer "row_number"
    t.integer "col_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flight_class_id"], name: "index_flight_seats_on_flight_class_id"
    t.index ["flight_id"], name: "index_flight_seats_on_flight_id"
  end

  create_table "flights", force: :cascade do |t|
    t.string "name"
    t.boolean "seats_ready"
    t.bigint "aeroplane_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "departure_date"
    t.index ["aeroplane_id"], name: "index_flights_on_aeroplane_id"
  end

  add_foreign_key "aeroplane_classes", "aeroplanes", on_delete: :cascade
  add_foreign_key "flight_classes", "aeroplane_classes", on_delete: :restrict
  add_foreign_key "flight_classes", "aeroplanes", on_delete: :restrict
  add_foreign_key "flight_classes", "flights", on_delete: :cascade
  add_foreign_key "flight_reservations", "flights", on_delete: :restrict
  add_foreign_key "flights", "aeroplanes", on_delete: :restrict
end
