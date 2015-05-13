ActiveAdmin.register Event do
  permit_params :name, 
    :description, 
    :starts_at, 
    :ends_at, 
    :created_by_user_id, 
    :organization_id,
    :pod_id,
    :address_json,
    :status,

  index do
    selectable_column
    id_column
    column :name
    column :starts_at
    column :ends_at
    column :status
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
      f.input :status, as: :select, collection: ['pending_approval', 'approved']
      f.input :starts_at, :as => :string, :input_html => {:class => "datetimepicker"}
      f.input :ends_at, :as => :string, :input_html => {:class => "datetimepicker"}
      f.input :creator
      f.input :organization
      f.input :pod
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

  controller do
    def create
      params[:event][:address_json] = params[:event].delete(:address).to_json
      super
    end

    def update
      params[:event][:address_json] = params[:event].delete(:address).to_json
      super
    end
  end
end
