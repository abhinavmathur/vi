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

ActiveRecord::Schema.define(version: 20160808063718) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name",                     null: false
    t.text     "description", default: ""
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "places", force: :cascade do |t|
    t.string   "name",            default: "",    null: false
    t.string   "address",         default: ""
    t.string   "city",            default: ""
    t.float    "lat"
    t.float    "lon"
    t.string   "full_address",    default: ""
    t.integer  "owner"
    t.boolean  "confirmed",       default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "slug"
    t.integer  "category_number"
  end

  add_index "places", ["name"], name: "index_places_on_name", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "title",       default: ""
    t.text     "description"
    t.integer  "category_id"
    t.string   "company"
    t.string   "tags"
    t.string   "asin"
    t.string   "slug"
    t.boolean  "adult",       default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree
  add_index "products", ["title"], name: "index_products_on_title", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "tags"
    t.string   "youtube_url"
    t.string   "other_video_url"
    t.string   "affiliate_tag"
    t.string   "affiliate_link"
    t.boolean  "has_youtube_link",  default: false
    t.integer  "reviewfiable_id"
    t.string   "reviewfiable_type"
    t.boolean  "publish"
    t.string   "slug"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "reviewer_id"
  end

  add_index "reviews", ["reviewer_id"], name: "index_reviews_on_reviewer_id", using: :btree
  add_index "reviews", ["reviewfiable_id", "reviewfiable_type"], name: "index_reviews_on_reviewfiable_id_and_reviewfiable_type", using: :btree
  add_index "reviews", ["title"], name: "index_reviews_on_title", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                   default: ""
    t.string   "address",                default: ""
    t.string   "phone_number",           default: ""
    t.string   "lat",                    default: ""
    t.string   "lng",                    default: ""
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
    t.boolean  "manager",                default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "reviews", "users", column: "reviewer_id"
end
