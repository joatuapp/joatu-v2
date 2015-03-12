class SetOnDeleteForForeignKeys < ActiveRecord::Migration
  def up
    remove_foreign_key :pod_memberships, :users
    add_foreign_key :pod_memberships, :users, on_delete: :cascade

    remove_foreign_key :pod_memberships, :pods
    add_foreign_key :pod_memberships, :pods, on_delete: :cascade

    remove_foreign_key :events, :pods
    add_foreign_key :events, :pods, on_delete: :nullify

    remove_foreign_key :events, column: :created_by_user_id
    add_foreign_key :events, :users, column: :created_by_user_id, on_delete: :nullify

    remove_foreign_key :events, :organizations
    add_foreign_key :events, :organizations, on_delete: :nullify

    remove_foreign_key :offers_and_requests, :users
    add_foreign_key :offers_and_requests, :users, on_delete: :cascade

    remove_foreign_key :offers_and_requests, :pods
    add_foreign_key :offers_and_requests, :pods, on_delete: :nullify

    remove_foreign_key :organization_memberships, :users
    add_foreign_key :organization_memberships, :users, on_delete: :cascade

    remove_foreign_key :organization_memberships, :organizations
    add_foreign_key :organization_memberships, :organizations, on_delete: :cascade

  end
end
