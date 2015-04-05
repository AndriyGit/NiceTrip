$(document).ready(function() {

  notice = $("#notice");
  if (notice.text().trim().length > 0) {
    notice.show();
    if (notice.hasClass('alert-success')) {
      setTimeout(function() {
        notice.hide("slow");
      }, 2500);
    }
  }

});
