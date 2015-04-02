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

    $('#search_city').click(function () {
        $.post('/base_objects/search', {city: city_input.val()})
        .done(function (data) {
          $('#city').parent().addClass('has-success');
          disableActionButtons();
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
            $('#city').parent().addClass('has-error');
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
