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
    community_offer_detail_attributes: [
      :id,
      :value_to_society,
      :producer_qualifications,
      :estimated_hours_of_work,
      :requirements_provided,
      :requirements_requested,
      :requests,
      :question_or_comment,
    ]

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
      f.input :starts_at, :as => :string
      f.input :ends_at, :as => :string
      f.input :creator
      f.input :organization
      f.input :pod
      # f.inputs "Address", for: f.object.address do |af|
      #   af.input :name
      #   af.input :address1
      #   af.input :address2
      #   af.input :city
      #   af.input :province
      #   af.input :country, as: :country
      #   af.input :postal_code
      # end

      f.inputs "Details", for: [:community_offer_detail_attributes, f.object.community_offer_detail] do |df|
        df.input :id, as: :hidden
        df.input :value_to_society
        df.input :producer_qualifications
        df.input :estimated_hours_of_work
        df.input :requirements_provided
        df.input :requirements_requested
        df.input :requests
        df.input :question_or_comment
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
