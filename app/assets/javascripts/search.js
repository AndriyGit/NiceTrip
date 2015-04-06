function addSearch() {
    addListenerForCancelSearch();
    var city_input = $('#city');
    var search_city = $('#search_city');
    city_input.keydown(function () {
        $('#city').parent().removeClass('has-error has-success');
        $('#error').empty();
        if ($(this).val().length) {
            search_city.removeAttr('disabled');
        } else {
            search_city.attr('disabled','disabled');
        }
    });

    $('#radius_range').change(function() {
        $('#radius').text($(this).val() + 'km');
    });

    $('#search_city').click(function () {
        $.post('/base_objects/search', {city: city_input.val(), radius: $('#radius_range').val()})
        .done(function (data) {
          $('#city').parent().addClass('has-success');
          disableActionButtons();
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
            $('#error').text(response.error);
            $('#city').parent().addClass('has-error');
            if (response.lat) {
              SearchMap.setCenter(response.lat, response.lng);
              SearchMap.addMarker({
                lat: response.lat,
                lng: response.lng,
              });
            }
        });
    });
}
function disableActionButtons() {
    $('#search_city').hide();
    $('#cancel_city').show();
    $('#city').attr('disabled','disabled');
}
function enableActionButtons() {
    $('#search_city').show();
    $('#cancel_city').hide();
    $('#city').removeAttr('disabled');
}
function addListenerForCancelSearch() {
    $('#cancel_city').click(function() {
        enableActionButtons();
        $('#city').parent().removeClass('has-error has-success');
        $('#city').focus().val('');
    });
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
