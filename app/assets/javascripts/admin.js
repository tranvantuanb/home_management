//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require moment
//= require bootstrap-datetimepicker
//= require bootstrap
//= require i18n
//= require i18n/translations
//= require_tree ./admin
$(document).on('turbolinks:load', function(){
  if ($('#chart-container').length > 0) {
    init_chart_basic_line();
  };
  $(".alert" ).fadeOut(10000);
})
