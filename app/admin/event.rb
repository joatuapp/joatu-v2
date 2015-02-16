ActiveAdmin.register Event do
  permit_params :name, :description, :starts_at, :ends_at, :pod_id

  index do
    selectable_column
    id_column
    column :name
    column :starts_at
    column :ends_at
    column :created_at
    actions
  end

  filter :name
  filter :starts_at
  filter :ends_at

  form do |f|
    f.inputs "Events" do
      f.input :name
      f.input :description
      f.input :starts_at
      f.input :ends_at
      f.input :pod
    end
    f.actions
  end
end
