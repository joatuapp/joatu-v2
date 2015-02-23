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

ActiveRecord::Schema.define(version: 20150223233950) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "unaccent"
  enable_extension "postgis"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.integer  "pod_id"
    t.json     "address_json"
    t.integer  "created_by_user_id"
    t.integer  "organization_id"
    t.geometry "latlng",             limit: {:srid=>0, :type=>"point"}
  end

  add_index "events", ["latlng"], name: "index_events_on_latlng", using: :gist

  create_table "mailboxer_conversation_opt_outs", force: :cascade do |t|
    t.integer "unsubscriber_id"
    t.string  "unsubscriber_type"
    t.integer "conversation_id"
  end

  add_index "mailboxer_conversation_opt_outs", ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id", using: :btree
  add_index "mailboxer_conversation_opt_outs", ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type", using: :btree

  create_table "mailboxer_conversations", force: :cascade do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "mailboxer_notifications", force: :cascade do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.string   "notification_code"
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "attachment"
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.boolean  "global",               default: false
    t.datetime "expires"
  end

  add_index "mailboxer_notifications", ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id", using: :btree
  add_index "mailboxer_notifications", ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type", using: :btree
  add_index "mailboxer_notifications", ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type", using: :btree
  add_index "mailboxer_notifications", ["type"], name: "index_mailboxer_notifications_on_type", using: :btree

  create_table "mailboxer_receipts", force: :cascade do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                 null: false
    t.boolean  "is_read",         default: false
    t.boolean  "trashed",         default: false
    t.boolean  "deleted",         default: false
    t.string   "mailbox_type"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "mailboxer_receipts", ["notification_id"], name: "index_mailboxer_receipts_on_notification_id", using: :btree
  add_index "mailboxer_receipts", ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type", using: :btree

  create_table "offers", force: :cascade do |t|
    t.string   "title"
    t.string   "summary"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id",     null: false
  end

  create_table "organization_memberships", force: :cascade do |t|
    t.integer  "organization_id",               null: false
    t.integer  "user_id",                       null: false
    t.string   "membership_types", default: [],              array: true
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "organization_memberships", ["membership_types"], name: "index_organization_memberships_on_membership_types", using: :gin
  add_index "organization_memberships", ["organization_id", "user_id"], name: "index_organization_memberships_on_organization_id_and_user_id", unique: true, using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "name",                                               null: false
    t.text     "description"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.geometry "latlng",       limit: {:srid=>0, :type=>"geometry"}
    t.json     "address_json"
  end

  add_index "organizations", ["latlng"], name: "index_organizations_on_latlng", using: :gist

  create_table "pod_memberships", force: :cascade do |t|
    t.integer  "pod_id",                        null: false
    t.integer  "user_id",                       null: false
    t.string   "membership_types", default: [],              array: true
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "pod_memberships", ["membership_types"], name: "index_pod_memberships_on_membership_types", using: :gin
  add_index "pod_memberships", ["pod_id", "user_id"], name: "index_pod_memberships_on_pod_id_and_user_id", unique: true, using: :btree

  create_table "pod_organization_relations", force: :cascade do |t|
    t.integer  "pod_id",          null: false
    t.integer  "organization_id", null: false
    t.string   "type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "pods", force: :cascade do |t|
    t.string   "name",                                              null: false
    t.text     "description"
    t.geometry "focus_area",  limit: {:srid=>0, :type=>"geometry"}, null: false
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  add_index "pods", ["focus_area"], name: "index_pods_on_focus_area", using: :gist

  create_table "profiles", force: :cascade do |t|
    t.string   "given_name"
    t.string   "surname"
    t.text     "about_me"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "user_id",             null: false
    t.json     "accepted_currencies"
    t.string   "tagline"
  end

  create_table "references", force: :cascade do |t|
    t.integer  "from_user_id", null: false
    t.integer  "to_user_id",   null: false
    t.text     "reference"
    t.integer  "rating"
    t.integer  "offer_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.datetime "deleted_at"
  end

  add_index "references", ["offer_id"], name: "index_references_on_offer_id", using: :btree
  add_index "references", ["to_user_id", "from_user_id"], name: "index_references_on_to_user_id_and_from_user_id", unique: true, using: :btree

  create_table "requests", force: :cascade do |t|
    t.string   "title"
    t.string   "summary"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id",     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                                                        default: "",    null: false
    t.string   "encrypted_password",                                           default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                                default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",                                            default: 0
    t.boolean  "is_admin",                                                     default: false, null: false
    t.json     "preferences_json"
    t.string   "postal_code"
    t.geometry "home_location",          limit: {:srid=>0, :type=>"geometry"}
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["home_location"], name: "index_users_on_home_location", using: :gist
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "events", "organizations"
  add_foreign_key "events", "users", column: "created_by_user_id"
  add_foreign_key "mailboxer_conversation_opt_outs", "mailboxer_conversations", column: "conversation_id", name: "mb_opt_outs_on_conversations_id"
  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", column: "conversation_id", name: "notifications_on_conversation_id"
  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", column: "notification_id", name: "receipts_on_notification_id"
  add_foreign_key "offers", "users", on_delete: :cascade
  add_foreign_key "organization_memberships", "organizations"
  add_foreign_key "organization_memberships", "users"
  add_foreign_key "pod_memberships", "pods"
  add_foreign_key "pod_memberships", "users"
  add_foreign_key "pod_organization_relations", "organizations"
  add_foreign_key "pod_organization_relations", "pods"
  add_foreign_key "profiles", "users", on_delete: :cascade
  add_foreign_key "requests", "users", on_delete: :cascade
end
