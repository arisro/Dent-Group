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

ActiveRecord::Schema.define(version: 20140704071815) do

  create_table "activities", force: true do |t|
    t.integer  "subject_id"
    t.string   "subject_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country",       limit: 3,             null: false
    t.string   "name",                                null: false
    t.integer  "from_user_id",                        null: false
    t.integer  "to_user_id"
    t.integer  "thumbs_up",               default: 0, null: false
    t.integer  "user_group_id"
  end

  add_index "activities", ["from_user_id"], name: "index_activities_on_from_user_id", using: :btree
  add_index "activities", ["subject_id", "subject_type"], name: "index_activities_on_subject_id_and_subject_type", using: :btree
  add_index "activities", ["subject_id"], name: "index_activities_on_subject_id", using: :btree
  add_index "activities", ["subject_type"], name: "index_activities_on_subject_type", using: :btree
  add_index "activities", ["to_user_id"], name: "index_activities_on_to_user_id", using: :btree

  create_table "bad_customer_comments", force: true do |t|
    t.integer  "bad_customer_id"
    t.integer  "user_id"
    t.text     "body"
    t.boolean  "deleted",         default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bad_customers", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "cnp"
    t.text     "message"
    t.boolean  "deleted",                   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "views"
    t.string   "website_country", limit: 3
  end

  create_table "chat_ignores", force: true do |t|
    t.integer "by_user_id", null: false
    t.integer "on_user_id", null: false
  end

  add_index "chat_ignores", ["by_user_id", "on_user_id"], name: "index_chat_ignores_on_by_user_id_and_on_user_id", unique: true, using: :btree
  add_index "chat_ignores", ["by_user_id"], name: "index_chat_ignores_on_by_user_id", using: :btree
  add_index "chat_ignores", ["on_user_id"], name: "index_chat_ignores_on_on_user_id", using: :btree

  create_table "chat_messages", force: true do |t|
    t.integer  "from_user_id"
    t.integer  "to_user_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "chat_messages", ["from_user_id"], name: "index_chat_messages_on_from_user_id", using: :btree
  add_index "chat_messages", ["to_user_id"], name: "index_chat_messages_on_to_user_id", using: :btree

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "homepage_messages", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "views",                                   default: 0
    t.integer  "user_id"
    t.datetime "published_at"
    t.boolean  "deleted",                                 default: false, null: false
    t.string   "website_country",               limit: 3
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "homepage_messages_category_id"
    t.integer  "priority",                                default: 1,     null: false
  end

  create_table "homepage_messages_categories", force: true do |t|
    t.string   "ident"
    t.boolean  "deleted",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.string   "company_name"
    t.string   "country"
    t.string   "city"
    t.integer  "type"
    t.integer  "count"
    t.string   "offer"
    t.datetime "valid_until"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status"
    t.boolean  "deleted",                      default: false
    t.integer  "views"
    t.string   "contact_phone"
    t.string   "contact_email"
    t.string   "website_country",    limit: 3
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "news", force: true do |t|
    t.string   "title"
    t.text     "summary"
    t.text     "body"
    t.integer  "views",                        default: 0
    t.integer  "user_id"
    t.datetime "published_at"
    t.boolean  "deleted",                      default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "website_country",    limit: 3
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "news_category_id"
  end

  create_table "news_categories", force: true do |t|
    t.string   "ident"
    t.integer  "deleted",    limit: 1, default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news_comments", force: true do |t|
    t.integer  "news_id"
    t.integer  "user_id"
    t.text     "body"
    t.boolean  "deleted",    default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "news_comments", ["news_id"], name: "index_news_comments_on_news_id", using: :btree

  create_table "offers", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "body"
    t.integer  "views"
    t.boolean  "deleted",                      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "website_country",    limit: 3
    t.integer  "type",                                         null: false
    t.text     "summary"
    t.string   "contact_phone"
    t.string   "contact_email"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "status_comments", force: true do |t|
    t.integer  "user_id",                    null: false
    t.integer  "status_id",                  null: false
    t.text     "message",                    null: false
    t.boolean  "deleted",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", force: true do |t|
    t.integer  "user_id",                                 null: false
    t.text     "message",                                 null: false
    t.boolean  "deleted",                 default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country",       limit: 3,                 null: false
    t.integer  "user_group_id"
  end

  create_table "statuses_uploads", force: true do |t|
    t.integer "status_id", null: false
    t.integer "upload_id", null: false
  end

  create_table "supplier_comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "supplier_id"
    t.text     "body"
    t.boolean  "deleted",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suppliers", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.string   "email"
    t.string   "phone"
    t.string   "website"
    t.string   "country"
    t.string   "city"
    t.text     "address"
    t.integer  "views"
    t.boolean  "deleted",                      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "website_country",    limit: 3
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "short_description"
  end

  create_table "uploads", force: true do |t|
    t.string   "uploaded_file_file_name"
    t.string   "uploaded_file_content_type"
    t.integer  "uploaded_file_file_size"
    t.datetime "uploaded_file_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_groups", force: true do |t|
    t.string   "ident"
    t.string   "name"
    t.boolean  "has_optin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                            default: "",    null: false
    t.string   "encrypted_password",               default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",                  default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fname"
    t.string   "lname"
    t.string   "profile_picture"
    t.string   "specialization"
    t.datetime "paid_until"
    t.integer  "roles_mask",                       default: 1
    t.string   "language",               limit: 5, default: "en"
    t.string   "country"
    t.string   "city"
    t.string   "phone"
    t.string   "skype"
    t.string   "yahoo"
    t.boolean  "is_online",                        default: false
    t.boolean  "chat_is_invisible",                default: false
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "users_user_groups", force: true do |t|
    t.integer  "user_id"
    t.integer  "user_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "versions", force: true do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
