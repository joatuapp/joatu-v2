ActiveAdmin.register Offer do
  permit_params :title, :description, :created_by_user_id

  index do
    selectable_column
    id_column
    column :title
    column :created_at
    actions
  end

  filter :title 
  filter :created_by_user

  form do |f|
    f.inputs "Offer" do
      f.input :title
      f.input :description
      f.select :created_by_user_id, User.all.map {|o| [o.name, o.id] }
    end
    f.actions
  end
end
