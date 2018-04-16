function initChosen (id) {
  $("#" + id).chosen({
    allow_single_deselect : true
  }).change(function() {
      $(this).parent().find(".chosen-container").removeClass("has-error");
  });
}
