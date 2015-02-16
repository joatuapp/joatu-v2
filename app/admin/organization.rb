ActiveAdmin.register Organization do
  permit_params :name, :description

  index do
    selectable_column
    id_column
    column :name
    column :created_at
    actions
  end

  filter :name

  form do |f|
    f.inputs "Organization" do
      f.input :name
      f.input :description
    end
    f.actions
  end
end
