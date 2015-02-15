setup_map_areas = ->
  $('[data-map-area]').each(->
    previous_overlay = null
    feature = null

    data_map = this

    data = $(data_map).data('geojson')

    new_overlay = (overlay)->
      overlay = overlay.overlay
      if previous_overlay
        previous_overlay.setVisible(false)
      previous_overlay = overlay

      overlay.setEditable(true)

      google.maps.event.addListener(overlay, 'mouseup', (mouse_event)=>
        update_feature(overlay)
      )

      update_feature(overlay)


    update_feature = (overlay)->
      rings = []
      overlay.getPaths().forEach((path) ->
        rings.push new google.maps.Data.LinearRing(path.getArray())
      )
      geo = new google.maps.Data.Polygon(rings) 
      if !feature
        feature = new google.maps.Data.Feature
        feature.setGeometry(geo)
      else
        feature.setGeometry(geo)

      feature.toGeoJson((json)->
        $(data_map).find('.map-area-coords-input').val(JSON.stringify(json))
      )
      

    handler = Gmaps.build('Google')

    handler.buildMap({ provider: {}, internal: {id: $(this).find('.map-container').attr('id')}}, =>
      if data
        features = handler.map.serviceObject.data.addGeoJson(data)
        feature = features.first
        feature.getGeometry().editable = true

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

      google.maps.event.addListener(drawingManager, 'overlaycomplete', new_overlay)
    )
  )


$(document).on "page:change", (e) ->
  setup_map_areas()
$(document).on "ready", (e) ->
  setup_map_areas()
