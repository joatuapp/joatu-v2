ActiveAdmin.register Pod do
  permit_params :name, :description, :focus_area, :hub_id

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
      f.select :hub_id, Organization.all.map {|o| [o.name, o.id] }
      f.input :focus_area, as: :map_area
    end
    f.actions
  end

  controller do
    def create
      params[:pod][:focus_area] = RGeo::GeoJSON.decode(params[:pod][:focus_area], json_parser: :json).geometry.to_s
      Rails.logger.debug "Params after meddling: #{params.inspect}"
      super
    end

    def update
      params[:pod][:focus_area] = RGeo::GeoJSON.decode(params[:pod][:focus_area], json_parser: :json).geometry.to_s
      Rails.logger.debug "Params after meddling: #{params.inspect}"
      super
    end
  end
end
