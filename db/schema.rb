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

ActiveRecord::Schema.define(version: 20150917042224) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "beverages", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "beverages", ["name"], name: "index_beverages_on_name", unique: true, using: :btree

  create_table "ingredients", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "ingredients", ["name"], name: "index_ingredients_on_name", unique: true, using: :btree

  create_table "recipes", force: :cascade do |t|
    t.integer  "beverage_id",   null: false
    t.integer  "ingredient_id", null: false
    t.integer  "parts",         null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "recipes", ["beverage_id"], name: "index_recipes_on_beverage_id", using: :btree
  add_index "recipes", ["ingredient_id"], name: "index_recipes_on_ingredient_id", using: :btree

  add_foreign_key "recipes", "beverages"
  add_foreign_key "recipes", "ingredients"
end
