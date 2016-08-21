// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require moment
//= require bootstrap-datetimepicker
//= require toastr
//= require onmount
//= require_tree .

$(document).on('ready show.bs closed.bs load page:change', function () {
  $.onmount()
});

$.onmount('body', function() {
  $('.services-card .header .actions label').on('click', function(){
    var id = $(this).data('id');
    var checkbox = $(this).parent().find('.enlist-radio');
    var card = $(this).parent().parent().parent();

    if ($(checkbox).is(':checked')) {
      $.ajax({
        url: '/services/'+ id + '/disable',
        method: 'POST'
      });
      $(card).removeClass('-enable');
      $(card).addClass('-disabled');
      window.reload()
    } else {
      $.ajax({
        url: '/services/'+ id + '/enable',
        method: 'POST'
      });
      $(card).addClass('-enable');
      $(card).removeClass('-disabled');
      window.reload()
    }
  });
});

$.onmount('[role=datetime-picker]', function() {
  $(this).datetimepicker({
    format: 'DD/MM/YYYY'
  });
});

$.onmount('select', function() {
  $(this).selectpicker();
});
