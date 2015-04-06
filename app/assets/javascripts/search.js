var eventHandler = function () {
    var options = {
        city: $('#city').val(),
        type_of_place: $('#type_of_place').val(),
        radius: $('#radius_range').val()
    };
    $.post('/base_objects/search', options)
    .done(function (data) {
      $('#city, #type_of_place').parent().removeClass('has-error').addClass('has-success');
      $('#error').hide();
      SearchMap.removeMarkers();
      addCurrentPosition();
      $.each(data, function(id, value) {
          SearchMap.setCenter(curr_lat, curr_lng);
          SearchMap.addMarker({
            lat: value.lat,
            lng: value.lng,
            title: value.name,
            infoWindow: {
              content: '<p>'+ value.type +'</p><br><img src = "'+ value.image_big +'"><p>' + value.name + '</p><p><a href="/base_objects/'+ id +'">Click me!</a></p>'
            },
            icon: value.image
          });
      });
    })
    .error(function (data) {
        var response = data.responseJSON;
        $('#error').show().text(response.error);
        $('#city, #type_of_place').parent().addClass('has-error');
        if (response.lat) {
          SearchMap.setCenter(response.lat, response.lng);
          SearchMap.addMarker({
            lat: response.lat,
            lng: response.lng,
          });
        }
    });
};

function addSearch() {
    $('#city').keydown(function () {
        $(this).parent().removeClass('has-error has-success');
        $('#type_of_place').parent().removeClass('has-error has-success');
        $('#error').empty();
        if ($(this).val().length) {
            $('#search_city').removeAttr('disabled');
        } else {
            $('#search_city').attr('disabled','disabled');
        }
    });
    $('#radius_range').change(function() {
        $('#radius').text($(this).val() + 'km');
    });
    $('#search_city').click(eventHandler);
    $('#type_of_place').change(eventHandler);
}
function addCurrentPosition() {
    SearchMap.addMarker({
        lat: curr_lat,
        lng: curr_lng,
        title: 'You are here!',
        infoWindow: {
          content: '<p>You are here!</p>'
        },
        icon: image
    });
}
