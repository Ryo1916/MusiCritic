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

  // validation for review form
  $('#review_form').submit(function(){
    const VALID_TITLE_AND_TEXT_REGEX_TO_START_ALPHABET = /^[\w]+/;
    const VALID_TITLE_AND_TEXT_REGEX = /[a-zA-Z\d\W\S]*$/
    var title = $('#review_title').val();
    var text = $('#review_text').val();

    if (title == "" || text == "") {
      if (title == "") {
        $('#title_error').text("* Please enter some title.");
        $('#title_error').show();
      }
      if (text == "") {
        $('#text_error').text("* Please enter some text.");
        $('#text_error').show();
      }
      return false;
    } else if (!VALID_TITLE_AND_TEXT_REGEX_TO_START_ALPHABET.test(title) || !VALID_TITLE_AND_TEXT_REGEX_TO_START_ALPHABET.test(text)){
      if (!VALID_TITLE_AND_TEXT_REGEX_TO_START_ALPHABET.test(title)) {
        $('#title_error').text("* You should start from alphabet.");
        $('#title_error').show();
      }
      if (!VALID_TITLE_AND_TEXT_REGEX_TO_START_ALPHABET.test(text)) {
        $('#text_error').text("* You should start from alphabet.");
        $('#text_error').show();
      }
      return false;
    } else if (!VALID_TITLE_AND_TEXT_REGEX.test(title) || !VALID_TITLE_AND_TEXT_REGEX.test(text)) {
      if (!VALID_TITLE_AND_TEXT_REGEX.test(title)) {
        $('#title_error').text("* Only can use alphabet, numbers and some symbols.");
        $('#title_error').show();
      }
      if (!VALID_TITLE_AND_TEXT_REGEX.test(text)) {
        $('#text_error').text("* Only can use alphabet, numbers and some symbols.");
        $('#text_error').show();
      }
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

  var path = window.location.pathname;
  if (path == '/artists') {
    $('#artists-list').infiniteScroll({
      path: "a#scroll-next",
      append: ".artist",
      history: false,
      prefill: false,
      status: '.page-load-status'
    });
  }
  if (path == '/albums') {
    $('#albums-list').infiniteScroll({
      path: "a#scroll-next",
      append: ".album",
      history: false,
      prefill: false,
      status: '.page-load-status'
    });
  }
});
