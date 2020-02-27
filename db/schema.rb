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

ActiveRecord::Schema.define(version: 2020_02_24_175229) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contracts", force: :cascade do |t|
    t.integer "programme"
    t.boolean "client_type", default: false
    t.integer "hourly_rate"
    t.date "start_from"
    t.date "end_at"
    t.string "target"
    t.string "sessions", default: [], array: true
    t.string "frequency", default: [], array: true
    t.string "teacher"
    t.integer "payment_condition"
    t.date "sign_date"
    t.string "first_name"
    t.string "last_name"
    t.string "tel"
    t.string "email"
    t.string "address"
    t.string "zipcode"
    t.string "city"
    t.string "company"
    t.string "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code"
    t.integer "installment"
    t.boolean "cpi_on_top"
    t.json "attendees", default: []
    t.integer "attendee_number", default: 1
    t.boolean "convention", default: false
    t.text "convention_signee"
    t.boolean "ext_group"
    t.boolean "direct_payment", default: false
    t.text "payer"
  end

  create_table "quotes", force: :cascade do |t|
    t.integer "programme"
    t.string "code"
    t.boolean "client_is_business", default: false
    t.integer "number_of_participants"
    t.json "participants", default: []
    t.date "start_from"
    t.date "end_at"
    t.float "hours"
    t.json "sessions", default: []
    t.json "frequency", default: []
    t.string "day_of_classes", default: [], array: true
    t.boolean "schedule_is_defined", default: false
    t.string "timeslots", default: [], array: true
    t.string "schedules", default: [], array: true
    t.string "client_first_name"
    t.string "client_last_name"
    t.string "client_tel"
    t.string "client_email"
    t.string "client_address"
    t.string "client_zipcode"
    t.string "client_city"
    t.string "company_name"
    t.string "company_address"
    t.string "company_zipcode"
    t.string "company_siret"
    t.string "company_city"
    t.integer "hourly_rate"
    t.integer "installment"
    t.string "level_target"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
