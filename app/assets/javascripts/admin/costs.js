$(document).on('turbolinks:load', function() {
  $('.datetime-picker').datetimepicker({
    format: 'DD/MM/YYYY',
    showClear: true,
  });
});
