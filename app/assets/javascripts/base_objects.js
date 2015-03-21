function addAddressFieldChangeEvent() {
  var address_field_value = '';
  $('#address_field').change(function() {
    $('#address_field').parent().removeClass('has-error');
    address_field_value = $('#address_field').val();
    GMaps.geocode({
      address: $('#address_field').val(),
      callback: function(results, status) {
        if (status == 'OK') {
          GoogleMap.removeMarkers();
          $('#address_field').parent().addClass('has-success');
          var latlng = results[0].geometry.location;
          addMarkerPosition(latlng.lat(), latlng.lng());
        } else {
          $('#address_field').parent().addClass('has-error');
          $('#address_field').val('Can not find this place');
        }
      }
    });
  }).focus(function() {
    $('#address_field').val(address_field_value);
  });
}
function addMarkerPosition(lat, lng) {
  GoogleMap.setCenter(lat, lng);
  var marker = GoogleMap.addMarker({
    lat: lat,
    lng: lng,
    draggable: true
  });
  addListenerForMarker(marker);
  //adding coordinats
  coordinatsChanged(lat, lng)
}
function addListenerForMarker(marker) {
  google.maps.event.addListener(marker, 'dragend', function() {
    //adding coordinats
    coordinatsChanged(marker.position.lat(), marker.position.lng());
  });
}
function coordinatsChanged(lat, lng) {
  $('#latitude').val(lat);
  $('#longitude').val(lng);
}
