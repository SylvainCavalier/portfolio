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

ActiveRecord::Schema[7.1].define(version: 2025_03_22_142841) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "github_url"
    t.string "image_url"
    t.string "tech_stack"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "language", default: "english"
  end

  create_table "sections", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "language", default: "english"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "language"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "steps", force: :cascade do |t|
    t.string "name"
    t.string "date"
    t.string "location"
    t.text "description"
    t.string "language"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
