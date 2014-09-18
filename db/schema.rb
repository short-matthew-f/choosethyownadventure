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

ActiveRecord::Schema.define(version: 20140911152451) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hallways", force: true do |t|
    t.integer  "entrance_id", null: false
    t.integer  "exit_id",     null: false
    t.string   "description", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hallways", ["entrance_id", "exit_id"], name: "index_hallways_on_entrance_id_and_exit_id", unique: true, using: :btree
  add_index "hallways", ["entrance_id"], name: "index_hallways_on_entrance_id", using: :btree
  add_index "hallways", ["exit_id"], name: "index_hallways_on_exit_id", using: :btree

  create_table "histories", force: true do |t|
    t.integer  "user_id",                null: false
    t.integer  "maze_id",                null: false
    t.integer  "room_id"
    t.integer  "win_count",  default: 0
    t.integer  "loss_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "histories", ["maze_id"], name: "index_histories_on_maze_id", using: :btree
  add_index "histories", ["user_id", "maze_id"], name: "index_histories_on_user_id_and_maze_id", unique: true, using: :btree
  add_index "histories", ["user_id"], name: "index_histories_on_user_id", using: :btree

  create_table "mazes", force: true do |t|
    t.integer  "author_id",                   null: false
    t.string   "title",                       null: false
    t.text     "description",                 null: false
    t.boolean  "published",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mazes", ["author_id"], name: "index_mazes_on_author_id", using: :btree

  create_table "pictures", force: true do |t|
    t.integer  "imageable_id",       null: false
    t.string   "imageable_type",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "profiles", force: true do |t|
    t.integer  "user_id",             null: false
    t.string   "name",                null: false
    t.string   "location",            null: false
    t.text     "biography"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", unique: true, using: :btree

  create_table "ratings", force: true do |t|
    t.integer  "maze_id",     null: false
    t.integer  "user_id",     null: false
    t.integer  "stars",       null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ratings", ["maze_id", "user_id"], name: "index_ratings_on_maze_id_and_user_id", unique: true, using: :btree
  add_index "ratings", ["maze_id"], name: "index_ratings_on_maze_id", using: :btree
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id", using: :btree

  create_table "rooms", force: true do |t|
    t.integer  "maze_id",                     null: false
    t.string   "name",                        null: false
    t.text     "description",                 null: false
    t.boolean  "start",       default: false
    t.boolean  "win",         default: false
    t.boolean  "lose",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rooms", ["maze_id"], name: "index_rooms_on_maze_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
