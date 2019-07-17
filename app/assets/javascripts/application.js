// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require infinite-scroll.pkgd.min
//= require jquery.raty.js
//= require popper
//= require bootstrap
//= require creative/cbpAnimatedHeader
//= require creative/classie
//= require creative/jquery.easing.min
//= require creative/jquery.fittext
//= require creative/wow.min
//= require creative/creative
//= require jquery.turbolinks
//= require turbolinks
//= require_tree .

$(document).ready(function(){
  // validate avatar
  $('.user').bind('change', function(){
    var size_in_megabytes = this.files[0].size/1024/1024;
    if (size_in_megabytes > 5) {
      alert('Maximum file size is 5MB. Please choose a smaller file.');
    }
  });
});

$(document).on('turbolinks:load', function() {
  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $('#avatar_img_prev').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

  // display uploaded image
  $("#user_avatar").change(function(){
    $('#avatar_img_prev').removeClass('hidden');
    $('.avatar_present_img').remove();
    readURL(this);
  });
});

// for scroll pagination
$(window).on('scroll', function() {
  scrollHeight = $(document).height();
  scrollPosition = $(window).height() + $(window).scrollTop();
  if ( (scrollHeight - scrollPosition) / scrollHeight <= 0.05) {
    $('.jscroll').jscroll({
      contentSelector: '.albums-list',
      nextSelector: 'a.jscroll-next'
    });
  }
});
