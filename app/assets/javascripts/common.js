$('[data-toggle="tooltip"]').tooltip();

$('.datepicker').datepicker({
  dateFormat : 'mm/dd/yy',
  prevText : '<i class="fa fa-chevron-left"></i>',
  nextText : '<i class="fa fa-chevron-right"></i>'
});

function initChosen (id) {
  $("#" + id).chosen({
    allow_single_deselect : true
  }).change(function() {
      $(this).parent().find(".chosen-container").removeClass("has-error");
  });
}

function isDate(field, rules, i, options) {
  var regex = new RegExp(/\b\d{1,2}[\/-]\d{1,2}[\/-]\d{4}\b/);
  var date = field.val();
  if(date != null || date  != ""){
    if (!regex.test(date)) {
      return validate_format_date
    }
  }
}

function isComparePassWord(field, rules, i, options) {
  var pass_comfirm = field.val()
  var pass = $("#user_password").val();

  if (pass_comfirm != null && pass_comfirm != "") {
    if (pass_comfirm != pass) {
      return validate_password_message;
    }
  }
}

function hidenErrorDateRange(targetid, sourceid) {
  if ($('#' + targetid).validationEngine('validate')){
    $('#' + sourceid).validationEngine('hide');
    $('#' + sourceid).removeClass("has-error");
  }
}

