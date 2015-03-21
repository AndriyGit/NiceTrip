$(document).ready(function() {
    handler = Gmaps.build('Google');
    handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
        markers = handler.addMarkers([
          {
            "lat": 0,
            "lng": 0,
            "picture": {
              "width":  38,
              "height": 38
            },
            "infowindow": "hello!"
              }
            ]);
        handler.bounds.extendWith(markers);
        handler.fitMapToBounds();
    });
});