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

ActiveRecord::Schema.define(version: 20160613053646) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.integer  "user_id"
    t.decimal  "mount",      precision: 8, scale: 2, default: 0.0
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "sex"
    t.string   "phone_number"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "contacts", force: :cascade do |t|
    t.string   "email"
    t.string   "name"
    t.string   "title"
    t.text     "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "guarantors", force: :cascade do |t|
    t.integer  "loan_id"
    t.string   "name"
    t.string   "id_card"
    t.string   "sex"
    t.string   "phone_number"
    t.string   "address"
    t.string   "job"
    t.decimal  "salary",       precision: 8, scale: 2
    t.string   "relationship"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "guarantors", ["loan_id"], name: "index_guarantors_on_loan_id", using: :btree

  create_table "investments", force: :cascade do |t|
    t.decimal  "mount",      precision: 8, scale: 2
    t.integer  "loan_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "investments_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "investment_id"
  end

  create_table "loans", force: :cascade do |t|
    t.integer  "user_id"
    t.decimal  "mount",         precision: 8, scale: 2,                 null: false
    t.string   "use"
    t.integer  "period"
    t.string   "way"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.string   "passed",                                default: "no"
    t.decimal  "salary",        precision: 8, scale: 2
    t.string   "job"
    t.string   "company_add"
    t.text     "message",                               default: ""
    t.decimal  "already_mount", precision: 8, scale: 2, default: 0.0
    t.boolean  "fulled",                                default: false
    t.decimal  "already_pay",   precision: 8, scale: 2, default: 0.0
    t.decimal  "should_return", precision: 8, scale: 2, default: 0.0
    t.jsonb    "return_money",                          default: []
  end

  add_index "loans", ["user_id"], name: "index_loans_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                                          default: "",  null: false
    t.string   "encrypted_password",                             default: "",  null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                  default: 0,   null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
    t.string   "name"
    t.string   "phone_number"
    t.string   "id_card"
    t.string   "sex"
    t.string   "address"
    t.decimal  "invest_count",           precision: 8, scale: 2, default: 0.0
    t.decimal  "profit_count",           precision: 8, scale: 2, default: 0.0
    t.decimal  "profit_not_yet",         precision: 8, scale: 2, default: 0.0
    t.decimal  "frozen_capital",         precision: 8, scale: 2, default: 0.0
    t.decimal  "capital_not_yet",        precision: 8, scale: 2, default: 0.0
    t.decimal  "valid_capital",          precision: 8, scale: 2, default: 0.0
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
