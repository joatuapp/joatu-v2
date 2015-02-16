setup_map_areas = ->
  $('[data-map-area]').each(->
    visible_overlay = null

    data_map = this

    data = $(data_map).data('geojson')

    update_from_feature = (feature)->
      if !visible_overlay
        visible_overlay = new google.maps.Polygon
        visible_overlay.setMap(handler.map.serviceObject)
        visible_overlay.setEditable(true)
        google.maps.event.addListener(visible_overlay, 'mouseup', (mouse_event)=>
          update_from_overlay({overlay: visible_overlay})
        )
      paths = []
      _.each(feature.getGeometry().getArray(), (path)->
        paths.push path.getArray()
      )
      visible_overlay.setPaths(paths)

      feature.toGeoJson((json)->
        $(data_map).find('.map-area-coords-input').val(JSON.stringify(json))
      )

    update_from_overlay = (overlay)->
      unless overlay.overlay == visible_overlay
        visible_overlay.setMap(null)
        visible_overlay.unbindAll()

      visible_overlay = overlay.overlay
      visible_overlay.setEditable(true)

      google.maps.event.addListener(visible_overlay, 'mouseup', (mouse_event)=>
        update_from_overlay({overlay: visible_overlay})
      )

      feature_from_overlay(visible_overlay).toGeoJson((json)->
        $(data_map).find('.map-area-coords-input').val(JSON.stringify(json))
      )
      
    feature_from_overlay = (overlay) ->
      rings = []
      overlay.getPaths().forEach((path) ->
        rings.push new google.maps.Data.LinearRing(path.getArray())
      )
      geo = new google.maps.Data.Polygon(rings) 
      feature = new google.maps.Data.Feature
      feature.setGeometry(geo)
      return feature

    handler = Gmaps.build('Google')

    handler.buildMap({ provider: {}, internal: {id: $(this).find('.map-container').attr('id')}}, =>
      if data
        feature = handler.map.serviceObject.data.addGeoJson(data)[0]
        update_from_feature(feature)
        handler.map.serviceObject.data.remove(feature)

      drawingManager = new google.maps.drawing.DrawingManager({
        drawingMode: google.maps.drawing.OverlayType.POLYGON,
        drawingControl: true,
        drawingControlOptions: {
          position: google.maps.ControlPosition.TOP_CENTER,
          drawingModes: [
            google.maps.drawing.OverlayType.CIRCLE,
            google.maps.drawing.OverlayType.POLYGON,
            google.maps.drawing.OverlayType.RECTANGLE
          ]
        },
        circle_options: {
          editable: true
        },
        polygon_options: {
          editable: true
        },
        rectangle_options: {
          editable: true
        }
      })
      drawingManager.setMap(handler.map.serviceObject)

      google.maps.event.addListener(drawingManager, 'overlaycomplete', update_from_overlay)
    )
  )


$(document).on "page:change", (e) ->
  setup_map_areas()
$(document).on "ready", (e) ->
  setup_map_areas()
