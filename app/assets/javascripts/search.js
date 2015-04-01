$(document).ready(function () {
    var city_input = $('#city');
    var search_city = $('#search_city');
    city_input.keydown(function () {
        $('#error').empty();
        if ($(this).val().length) {
            search_city.removeAttr('disabled');
        } else {
            search_city.attr('disabled','disabled');
        }
    });

    $('#search_city').click(function () {
        $.post('/base_objects/search', {city: city_input.val()})
        .done(function (data){
          $.each(data, function(id, value){
              SearchMap.setCenter(value.lat, value.lng);
              SearchMap.addMarker({
                lat: value.lat,
                lng: value.lng,
                title: value.name,
                infoWindow: {
                  content: '<p>'+ value.type +'</p><br><img src = "'+ value.image_big +'"><p>' + value.name + '</p>'
                },
                icon: value.image
              });
          });
        })
        .error(function (data) {
            $('#error').text(data.responseJSON.error);
        });
    });
});
