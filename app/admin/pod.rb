ActiveAdmin.register Pod do
  permit_params :name, :description, :focus_area

  index do
    selectable_column
    id_column
    column :name
    column :created_at
    actions
  end

  filter :name

  form do |f|
    f.inputs "Pod Details" do
      f.input :name
      f.input :description
      f.select :hub, Organization.all.map {|o| [o.name, o.id] }
      f.input :focus_area, as: :map_area
    end
    f.actions
  end
end
