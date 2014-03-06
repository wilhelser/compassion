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

ActiveRecord::Schema.define(version: 20140306224339) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"
  enable_extension "fuzzystrmatch"

  create_table "active_admin_comments", force: true do |t|
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_admin_notes_on_resource_type_and_resource_id", using: :btree

  create_table "addresses", force: true do |t|
    t.integer  "contractor_id", null: false
    t.string   "address"
    t.string   "addres2"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "address_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "adjusters", force: true do |t|
    t.string   "email",                             default: "",    null: false
    t.string   "encrypted_password",                default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "company"
    t.string   "first_name",                                        null: false
    t.string   "last_name",                                         null: false
    t.string   "phone"
    t.string   "fax"
    t.string   "street_address",                                    null: false
    t.string   "city",                                              null: false
    t.string   "state",                   limit: 2,                 null: false
    t.integer  "zip_code",                                          null: false
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "approved",                          default: false
    t.string   "cell_phone"
    t.text     "state_licensed_in"
    t.string   "license_number"
    t.date     "date_license_issued"
    t.date     "license_expiration_date"
    t.string   "license"
    t.boolean  "notify_on_assignment",              default: true
  end

  add_index "adjusters", ["email"], name: "index_adjusters_on_email", unique: true, using: :btree
  add_index "adjusters", ["reset_password_token"], name: "index_adjusters_on_reset_password_token", unique: true, using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "assignments", force: true do |t|
    t.integer  "project_id",  null: false
    t.integer  "adjuster_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.integer  "position"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.text     "description"
    t.string   "icon"
    t.string   "slug",        limit: 80
  end

  create_table "categories_projects", id: false, force: true do |t|
    t.integer "category_id"
    t.integer "project_id"
  end

  add_index "categories_projects", ["category_id", "project_id"], name: "categories_projects_index", unique: true, using: :btree

  create_table "contractor_reviews", force: true do |t|
    t.integer  "contractor_id",                            null: false
    t.integer  "user_id",                                  null: false
    t.integer  "rating",        limit: 2
    t.string   "title",         limit: 60,                 null: false
    t.text     "comments",                                 null: false
    t.boolean  "approved",                 default: false
    t.boolean  "private",                  default: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "project_id",                               null: false
  end

  create_table "contractor_selections", force: true do |t|
    t.integer "contractor_id"
    t.integer "project_id"
  end

  create_table "contractors", force: true do |t|
    t.string   "name",                                                              null: false
    t.string   "street_address",                                                    null: false
    t.string   "city",                                                              null: false
    t.string   "state",                                                             null: false
    t.integer  "zip_code",                     limit: 8,                            null: false
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "coverage_radius",                         default: 25
    t.string   "logo"
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
    t.string   "business_legal_name"
    t.string   "business_dba_name"
    t.date     "date_of_incorporation"
    t.string   "owner_first_name"
    t.string   "owner_last_name"
    t.string   "owner_phone"
    t.string   "owner_email"
    t.string   "mailing_address"
    t.string   "mailing_address2"
    t.integer  "mailing_zip_code",             limit: 8
    t.string   "mailing_city"
    t.string   "mailing_state"
    t.boolean  "mailing_same"
    t.string   "business_tax_id_no"
    t.string   "ein"
    t.integer  "number_of_employees"
    t.string   "contractor_license_number"
    t.string   "gross_annual_sales_last_year"
    t.text     "description"
    t.string   "email",                                   default: "",              null: false
    t.string   "encrypted_password",                      default: "",              null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                           default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "authentication_token"
    t.string   "status",                                  default: "Not Submitted", null: false
    t.boolean  "terms"
    t.boolean  "preferred",                               default: false
    t.string   "website_url"
    t.string   "slug"
    t.boolean  "gmaps"
    t.boolean  "notify_on_select",                        default: true
    t.boolean  "notify_on_review",                        default: true
    t.string   "cell_phone",                   limit: 30
  end

  add_index "contractors", ["slug"], name: "index_contractors_on_slug", unique: true, using: :btree

  create_table "contractors_trades", id: false, force: true do |t|
    t.integer "contractor_id"
    t.integer "trade_id"
  end

  add_index "contractors_trades", ["contractor_id", "trade_id"], name: "contractors_trades_index", unique: true, using: :btree

  create_table "contributions", force: true do |t|
    t.integer  "project_id",                                                          null: false
    t.decimal  "amount",                      precision: 8, scale: 2, default: 0.0,   null: false
    t.datetime "created_at",                                                          null: false
    t.datetime "updated_at",                                                          null: false
    t.text     "comments"
    t.string   "stripe_card_token"
    t.boolean  "private",                                             default: false
    t.string   "address"
    t.string   "address_2"
    t.string   "city"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "image"
    t.string   "state",             limit: 2
    t.string   "zip_code",          limit: 5
  end

  create_table "donations", force: true do |t|
    t.decimal  "amount",                        precision: 8, scale: 2
    t.string   "name",              limit: 100
    t.integer  "zip_code",          limit: 8
    t.text     "comments"
    t.string   "city",              limit: 60
    t.string   "state",             limit: 2
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.string   "stripe_card_token"
    t.string   "email"
  end

  create_table "estimates", force: true do |t|
    t.integer  "project_id",                                        null: false
    t.integer  "adjuster_id",                                       null: false
    t.decimal  "amount",      precision: 8, scale: 2, default: 0.0, null: false
    t.text     "description"
    t.string   "document",                                          null: false
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  create_table "galleries", force: true do |t|
    t.integer  "project_id"
    t.string   "title",         null: false
    t.text     "description"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "contractor_id"
    t.string   "gallery_type"
  end

  create_table "pages", force: true do |t|
    t.string   "title",          null: false
    t.text     "content",        null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "slug"
    t.string   "title_override"
  end

  create_table "pg_search_documents", force: true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: true do |t|
    t.integer  "gallery_id", null: false
    t.string   "caption"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "image",      null: false
    t.string   "key"
  end

  create_table "profiles", force: true do |t|
    t.integer  "user_id",    null: false
    t.string   "first_name", null: false
    t.string   "last_name"
    t.string   "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: true do |t|
    t.integer  "user_id"
    t.decimal  "goal_amount"
    t.string   "page_title",              limit: 60,                         null: false
    t.integer  "zip_code",                limit: 8,                          null: false
    t.text     "page_message",                                               null: false
    t.string   "slug"
    t.boolean  "approved",                           default: true,          null: false
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
    t.string   "featured_image"
    t.string   "featured_video"
    t.integer  "project_category_id"
    t.string   "status",                             default: "In Progress"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "notify_on_donate"
    t.boolean  "private",                            default: false
    t.boolean  "has_reviewed_contractor",            default: false
    t.integer  "backer_count",                       default: 0
    t.date     "project_deadline"
    t.text     "reason_for_deadline"
    t.boolean  "funded",                             default: false
    t.date     "funded_date"
    t.boolean  "funded_confirm",                     default: false
    t.boolean  "campaign_ended",                     default: false
    t.string   "key"
    t.date     "campaign_ended_date"
    t.date     "campaign_extended_date"
  end

  add_index "projects", ["slug"], name: "index_projects_on_slug", unique: true, using: :btree

  create_table "projects_trades", id: false, force: true do |t|
    t.integer "project_id", null: false
    t.integer "trade_id",   null: false
  end

  create_table "references", force: true do |t|
    t.integer  "contractor_id",      null: false
    t.string   "reference_type",     null: false
    t.string   "company_name"
    t.string   "time_affiliated"
    t.string   "contact_first_name", null: false
    t.string   "contact_last_name",  null: false
    t.string   "address"
    t.string   "address2"
    t.string   "city",               null: false
    t.string   "state",              null: false
    t.integer  "zip_code"
    t.string   "phone_number"
    t.string   "email"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "trades", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "updates", force: true do |t|
    t.integer  "project_id",                 null: false
    t.text     "body",                       null: false
    t.boolean  "facebook",   default: false
    t.boolean  "twitter",    default: false
    t.boolean  "email",      default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "title"
  end

  create_table "users", force: true do |t|
    t.string   "email",                            default: "", null: false
    t.string   "encrypted_password",               default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.string   "username"
    t.string   "slug"
    t.string   "profile_image"
    t.string   "city"
    t.string   "state",                  limit: 2
    t.integer  "zip_code",               limit: 8
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "vendors", force: true do |t|
    t.integer  "project_id",                                                         null: false
    t.string   "name",           limit: 100,                                         null: false
    t.decimal  "amount",                     precision: 8, scale: 2,                 null: false
    t.string   "contact_name",   limit: 100
    t.string   "address",        limit: 100
    t.string   "city",           limit: 80
    t.string   "state",          limit: 2
    t.integer  "zip_code"
    t.string   "phone",          limit: 20
    t.string   "invoice_number", limit: 100
    t.text     "description"
    t.string   "documentation"
    t.boolean  "verified",                                           default: false
    t.datetime "created_at",                                                         null: false
    t.datetime "updated_at",                                                         null: false
    t.date     "due_date"
    t.string   "account_no"
    t.boolean  "paid",                                               default: false
  end

end
