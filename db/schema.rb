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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110913090319) do

  create_table "albums", :force => true do |t|
    t.string   "name"
    t.integer  "level"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "web_url"
  end

  create_table "albums_photos", :force => true do |t|
    t.integer  "album_id"
    t.integer  "photo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "avatars", :force => true do |t|
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "cities", :force => true do |t|
    t.string  "name"
    t.integer "level"
  end

  create_table "comments", :force => true do |t|
    t.integer  "photo_id"
    t.integer  "user_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "communities", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "communities_users", :force => true do |t|
    t.integer  "community_id"
    t.integer  "user_id"
    t.integer  "level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fans", :force => true do |t|
    t.integer  "master_id"
    t.integer  "fan_id"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorite_photos", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "photo_id"
  end

  create_table "messages", :force => true do |t|
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "from_id"
    t.integer  "to_id"
  end

  create_table "photos", :force => true do |t|
    t.string   "uri"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "album_id"
    t.integer  "count"
    t.string   "web_url"
    t.string   "description"
  end

  create_table "photos_tags", :id => false, :force => true do |t|
    t.integer "photo_id", :default => 0
    t.integer "tag_id",   :default => 0
  end

  create_table "points", :force => true do |t|
    t.integer  "user_id"
    t.integer  "photo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rels", :force => true do |t|
    t.integer  "master_id"
    t.integer  "follower_id"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "level",      :default => 0
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.integer  "sex"
    t.string   "email"
    t.string   "pwd"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "community_id"
    t.integer  "level"
    t.integer  "avatar_id"
    t.date     "birthday"
    t.integer  "city_id"
    t.integer  "user_type"
  end

  create_table "users_tags", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "tag_id"
  end

end
