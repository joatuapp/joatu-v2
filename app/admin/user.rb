ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :is_admin, :postal_code, :pod_id

  includes :pod

  index do
    selectable_column
    id_column
    column :email

    column "Pod" do |user|
      if user.pod.id
        link_to user.pod.name, admin_pod_path(user.pod)
      else
        user.pod.name
      end
    end

    column :postal_code

    column :is_admin
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :is_admin
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :postal_code
      f.input :is_admin
      f.input :pod, as: :select, collection: Pod.all.select(:id, :name), member_label: :name
    end
    f.actions
  end

  controller do
    def update
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].delete("password")
        params[:user].delete("password_confirmation")
      end
      super
    end
  end
end
