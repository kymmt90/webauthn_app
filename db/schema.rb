# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_17_130655) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "users", force: :cascade do |t|
    t.string "uid", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["uid"], name: "index_users_on_uid", unique: true
  end

  create_table "webauthn_credentials", force: :cascade do |t|
    t.text "public_key", null: false
    t.integer "sign_count", default: 0, null: false
    t.bigint "setting_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["setting_id"], name: "index_webauthn_credentials_on_setting_id"
  end

  create_table "webauthn_settings", force: :cascade do |t|
    t.string "user_handle", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_handle"], name: "index_webauthn_settings_on_user_handle", unique: true
    t.index ["user_id"], name: "index_webauthn_settings_on_user_id"
  end

  add_foreign_key "webauthn_credentials", "webauthn_settings", column: "setting_id"
  add_foreign_key "webauthn_settings", "users"
end
