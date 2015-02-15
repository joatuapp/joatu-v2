require 'render_anywhere'

class MapAreaInput
  include Formtastic::Inputs::Base
  include RenderAnywhere

  def to_html
    geojson = @object.send("#{@method}_geojson")
    render template: "inputs/map_area", layout: false, locals: {
      geojson: geojson,
      method: @method,
    }
  end
end
