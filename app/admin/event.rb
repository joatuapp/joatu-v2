ActiveAdmin.register Event do
  permit_params :name, 
    :description, 
    :starts_at, 
    :ends_at, 
    :created_by_user_id, 
    :organization_id,
    address: [:address1, :address2, :city, :province, :country, :postal_code]

  index do
    selectable_column
    id_column
    column :name
    column :starts_at
    column :ends_at
    column :creator
    column :created_at
    actions
  end

  filter :name
  filter :creator
  filter :starts_at
  filter :ends_at

  form do |f|
    f.inputs "Events" do
      f.input :name
      f.input :description
      f.input :starts_at
      f.input :ends_at
      f.input :creator
      f.input :organization
      f.inputs "Address", for: [:address, f.object.address] do |af|
        af.input :address1
        af.input :address2
        af.input :city
        af.input :province
        af.input :country, as: :country
        af.input :postal_code
      end
    end
    f.actions
  end
end
