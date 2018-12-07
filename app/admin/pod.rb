ActiveAdmin.register Pod do
  permit_params :name, :description, :focus_area, :hub_id

  includes :hub

  index do
    selectable_column
    id_column
    column :name
    column "Organization" do |pod|
      pod.hub
    end
    column :created_at
    actions
  end

  filter :name

  form do |f|
    f.inputs "Pod Details" do
      f.input :name
      f.input :description
      f.input :hub_id, as: :select, collection: Organization.all.select(:id, :name), member_label: :name, label: 'Organization'
      f.input :focus_area, as: :map_area
    end
    f.actions
  end

  controller do
    def create
      params[:pod][:focus_area] = RGeo::GeoJSON.decode(params[:pod][:focus_area], json_parser: :json).geometry.to_s
      super
    end

    def update
      params[:pod][:focus_area] = RGeo::GeoJSON.decode(params[:pod][:focus_area], json_parser: :json).geometry.to_s
      super
    end
  end
end
