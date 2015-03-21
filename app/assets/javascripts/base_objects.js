$(document).ready(function(){
  var address_field_value = '';
  $('#address_field').change(function(){
    $('#address_field').parent().removeClass('has-error');
    address_field_value = $('#address_field').val();
    GMaps.geocode({
      address: $('#address_field').val(),
      callback: function(results, status) {
        if (status == 'OK') {
          $('#address_field').parent().addClass('has-success');
          var latlng = results[0].geometry.location;
          map.setCenter(latlng.lat(), latlng.lng());
          map.addMarker({
            lat: latlng.lat(),
            lng: latlng.lng()
          });
          //adding coordinats
          $('#latitude').val(latlng.lat());
          $('#longitude').val(latlng.lng());
        } else {
          $('#address_field').parent().addClass('has-error');
          $('#address_field').val('Can not find this place');
        }
      }
    });
  }).focus(function() {
    $('#address_field').val(address_field_value);
  });
});
