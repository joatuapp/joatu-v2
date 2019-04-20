
var setup_datetime_pickers, setup_map_areas;

setup_map_areas = function() {
  return $('[data-map-area]').each(function() {
    var data, data_map, feature_from_overlay, handler, update_from_feature, update_from_overlay, visible_overlay, bounds;
    visible_overlay = null;
    data_map = this;
    data = $(data_map).data('geojson');
    bounds = $(data_map).data('bounds');
    update_from_feature = function(feature) {
      var paths;
      if (!visible_overlay) {
        visible_overlay = new google.maps.Polygon;
        visible_overlay.setMap(handler.map.serviceObject);
        visible_overlay.setEditable(true);
        google.maps.event.addListener(visible_overlay, 'mouseup', (function(_this) {
          return function(mouse_event) {
            return update_from_overlay({
              overlay: visible_overlay
            });
          };
        })(this));
      }
      paths = [];
      _.each(feature.getGeometry().getArray(), function(path) {
        return paths.push(path.getArray());
      });
      visible_overlay.setPaths(paths);
      return feature.toGeoJson(function(json) {
        return $(data_map).find('.map-area-coords-input').val(JSON.stringify(json));
      });
    };
    update_from_overlay = function(overlay) {
      if (visible_overlay && overlay.overlay !== visible_overlay) {
        visible_overlay.setMap(null);
        visible_overlay.unbindAll();
      }
      visible_overlay = overlay.overlay;
      visible_overlay.setEditable(true);
      google.maps.event.addListener(visible_overlay, 'mouseup', (function(_this) {
        return function(mouse_event) {
          return update_from_overlay({
            overlay: visible_overlay
          });
        };
      })(this));
      return feature_from_overlay(visible_overlay).toGeoJson(function(json) {
        return $(data_map).find('.map-area-coords-input').val(JSON.stringify(json));
      });
    };
    feature_from_overlay = function(overlay) {
      var feature, geo, rings;
      rings = [];
      overlay.getPaths().forEach(function(path) {
        return rings.push(new google.maps.Data.LinearRing(path.getArray()));
      });
      geo = new google.maps.Data.Polygon(rings);
      feature = new google.maps.Data.Feature;
      feature.setGeometry(geo);
      return feature;
    };
    handler = Gmaps.build('Google');
    return handler.buildMap({
      provider: {},
      internal: {
        id: $(this).find('.map-container').attr('id')
      }
    }, (function(_this) {
      return function() {
        var drawingManager, feature, bounds_obj, ne, sw;
        if (data) {
          feature = handler.map.serviceObject.data.addGeoJson(data)[0];
          update_from_feature(feature);
          handler.map.serviceObject.data.remove(feature);
        }

        if (bounds) {
          sw = new google.maps.LatLng(bounds[0][0], bounds[0][1]);
          ne = new google.maps.LatLng(bounds[1][0], bounds[1][1]);
          bounds_obj = new google.maps.LatLngBounds(sw, ne);
          handler.map.serviceObject.fitBounds(bounds_obj);
        }

        drawingManager = new google.maps.drawing.DrawingManager({
          drawingMode: google.maps.drawing.OverlayType.POLYGON,
          drawingControl: true,
          drawingControlOptions: {
            position: google.maps.ControlPosition.TOP_CENTER,
            drawingModes: [google.maps.drawing.OverlayType.POLYGON, google.maps.drawing.OverlayType.RECTANGLE]
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
        });
        drawingManager.setMap(handler.map.serviceObject);
        return google.maps.event.addListener(drawingManager, 'overlaycomplete', update_from_overlay);
      };
    })(this));
  });
};

setup_datetime_pickers = function() {
  return $('input.hasDatetimePicker, .datetimepicker').datetimepicker({
    dateFormat: "dd/mm/yyyy",
    beforeShow: function() {
      return setTimeout(function() {
        return $('#ui-datepicker-div').css('z-index', 3000);
      });
    }
  });
};

$(document).ready(function(e) {
  console.log('test');
  $('head').append('<script defer async src="//maps.google.com/maps/api/js?v=3.13&amp;key=AIzaSyCJlym5rNyFZzA9GOs0IA9pz-jfyinGiKo&amp;sensor=false&amp;libraries=geometry,drawing&amp;callback=setup_map_areas"></script>');
  setup_datetime_pickers();
});
