
var setup_maps;

setup_maps = function() {
  return $('[data-map]').each(function() {
    var bounds, data_map_element, geojson, handler;
    data_map_element = $(this);
    geojson = data_map_element.data('geojson');
    bounds = data_map_element.data('bounds');
    handler = Gmaps.build('Google');
    return handler.buildMap({
      provider: {
        disableDefaultUI: true
      },
      internal: {
        id: data_map_element.find('.map-container').attr('id')
      }
    }, function() {
      var bounds_obj, ne, sw;
      if (geojson) {
        handler.map.serviceObject.data.addGeoJson(geojson);
      }
      if (bounds) {
        sw = new google.maps.LatLng(bounds[0][0], bounds[0][1]);
        ne = new google.maps.LatLng(bounds[1][0], bounds[1][1]);
        bounds_obj = new google.maps.LatLngBounds(sw, ne);
        return handler.map.serviceObject.fitBounds(bounds_obj);
      }
    });
  });
};
