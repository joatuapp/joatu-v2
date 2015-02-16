setup_maps = ->
  $('[data-map]').each(->
    data_map_element = $(this)
    geojson = data_map_element.data('geojson')
    bounds = data_map_element.data('bounds')

    handler = Gmaps.build('Google')
    handler.buildMap({
      provider: {
        disableDefaultUI: true
      },
      internal: {
        id: data_map_element.find('.map-container').attr('id')
      }}, ->
        if geojson
          handler.map.serviceObject.data.addGeoJson(geojson)
        if bounds
          sw = new google.maps.LatLng(bounds[0][0], bounds[0][1])
          ne = new google.maps.LatLng(bounds[1][0], bounds[1][1])
          bounds_obj = new google.maps.LatLngBounds(sw, ne)
          handler.map.serviceObject.fitBounds(bounds_obj)
    )
  )
    

$(document).on "page:change", (e) ->
  setup_maps()
$(document).on "ready", (e) ->
  setup_maps()
