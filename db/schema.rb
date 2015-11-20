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

ActiveRecord::Schema.define(version: 20150527002153) do

  create_table "boards", force: :cascade do |t|
    t.string   "name"
    t.text     "descricao"
    t.integer  "dynamic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "color"
  end

  add_index "boards", ["dynamic_id"], name: "index_boards_on_dynamic_id"

  create_table "dynamics", force: :cascade do |t|
    t.string   "name"
    t.text     "descricao"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "user_id"
    t.string   "color"
    t.datetime "final"
    t.integer  "numerodenotas"
    t.boolean  "votation"
    t.integer  "votationnumber"
  end

  add_index "dynamics", ["user_id"], name: "index_dynamics_on_user_id"

  create_table "notes", force: :cascade do |t|
    t.integer  "board_id"
    t.text     "text"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "color"
    t.string   "email"
    t.integer  "dynamic_id"
    t.integer  "numerodanota"
  end

  add_index "notes", ["board_id"], name: "index_notes_on_board_id"
  add_index "notes", ["dynamic_id"], name: "index_notes_on_dynamic_id"

  create_table "notifications", force: :cascade do |t|
    t.string   "text"
    t.boolean  "estado"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id"

  create_table "participants", force: :cascade do |t|
    t.string   "email"
    t.integer  "dynamic_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "name"
    t.boolean  "vote"
  end

  add_index "participants", ["dynamic_id"], name: "index_participants_on_dynamic_id"

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "email",                          null: false
    t.string   "encrypted_password", limit: 128, null: false
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128, null: false
    t.string   "nome"
  end

  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

  create_table "votes", force: :cascade do |t|
    t.integer  "participant_id"
    t.integer  "dynamic_id"
    t.integer  "note_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "votes", ["dynamic_id"], name: "index_votes_on_dynamic_id"
  add_index "votes", ["note_id"], name: "index_votes_on_note_id"
  add_index "votes", ["participant_id"], name: "index_votes_on_participant_id"

  create_table "whatis", force: :cascade do |t|
    t.string   "index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
