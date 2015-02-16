require 'render_anywhere'

class MapAreaInput
  include Formtastic::Inputs::Base
  include RenderAnywhere

  def to_html
    geojson = @object.to_geojson
    render template: "inputs/map_area", layout: false, locals: {
      geojson: geojson,
      method: @method,
      object_name: @object_name,
    }
  end
end
