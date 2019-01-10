ActiveAdmin.register Offer do
  permit_params :title, :description, :user_id

  includes :pod, :user

  index do
    selectable_column
    id_column
    column :title

    column "Pod" do |offer|
      if offer.pod.id
        link_to offer.pod.name, admin_pod_path(offer.pod)
      else
        offer.pod.name
      end
    end

    column :user

    column :created_at
    actions
  end

  filter :title 
  filter :created_by_user

  form do |f|
    f.inputs "Offer" do
      f.input :title
      f.input :description
      f.input :pod, as: :select, collection: Pod.all.select(:id, :name), member_label: :name
      f.select :user_id, User.all.map {|o| [o.name, o.id] }
    end
    f.actions
  end
end
