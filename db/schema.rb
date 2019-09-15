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

ActiveRecord::Schema.define(version: 2019_09_14_223753) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "clabe", null: false
    t.decimal "balance", precision: 10, scale: 2, null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["clabe"], name: "index_accounts_on_clabe", unique: true
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", limit: 64, null: false
    t.string "code", limit: 16, null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_roles_on_code", unique: true
    t.index ["user_id"], name: "index_roles_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.string "source_account", null: false
    t.string "destination_account", null: false
    t.decimal "amount", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", limit: 64, null: false
    t.string "password_digest", null: false
    t.string "email", limit: 64, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "accounts", "users"
end
