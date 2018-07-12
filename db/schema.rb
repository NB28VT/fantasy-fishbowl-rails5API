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

ActiveRecord::Schema.define(version: 20180710135433) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "concert_predictions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "concert_id"
    t.integer  "score",      default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["concert_id"], name: "index_concert_predictions_on_concert_id", using: :btree
    t.index ["user_id"], name: "index_concert_predictions_on_user_id", using: :btree
  end

  create_table "concert_sets", force: :cascade do |t|
    t.integer  "concert_id"
    t.integer  "set_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["concert_id"], name: "index_concert_sets_on_concert_id", using: :btree
  end

  create_table "concerts", force: :cascade do |t|
    t.string   "venue_name"
    t.date     "show_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prediction_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "song_performances", force: :cascade do |t|
    t.integer  "concert_set_id"
    t.integer  "song_id"
    t.integer  "setlist_position"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["concert_set_id"], name: "index_song_performances_on_concert_set_id", using: :btree
    t.index ["song_id"], name: "index_song_performances_on_song_id", using: :btree
  end

  create_table "song_predictions", force: :cascade do |t|
    t.integer  "concert_prediction_id"
    t.integer  "song_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "prediction_category_id"
    t.index ["concert_prediction_id"], name: "index_song_predictions_on_concert_prediction_id", using: :btree
    t.index ["song_id"], name: "index_song_predictions_on_song_id", using: :btree
  end

  create_table "songs", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "concert_predictions", "concerts"
  add_foreign_key "concert_predictions", "users"
  add_foreign_key "concert_sets", "concerts"
  add_foreign_key "song_performances", "concert_sets"
  add_foreign_key "song_performances", "songs"
  add_foreign_key "song_predictions", "concert_predictions"
  add_foreign_key "song_predictions", "songs"
end
