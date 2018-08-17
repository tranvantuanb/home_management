$(document).on('turbolinks:load', function(){
  $('#month').change(function() {
    $.ajax({
      type: 'GET',
      url: '/admin/users/get_user_cost_info',
      data:  {month: $(this).val()},
      success: function(data){
        $('#user-costs').html(data);
      }
    });
  });
})
