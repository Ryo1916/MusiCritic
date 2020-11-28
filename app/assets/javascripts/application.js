//= require jquery
//= require jquery_ujs
//= require infinite-scroll.pkgd.min
//= require jquery.raty.js
//= require popper
//= require bootstrap
//= require jquery.lazyload
//= require creative/cbpAnimatedHeader
//= require creative/classie
//= require creative/jquery.easing.min
//= require creative/jquery.fittext
//= require creative/wow.min
//= require creative/creative
//= require jquery.turbolinks
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function() {
  $("img").lazyload();

  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $('#avatar_img_prev').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

  // validate avatar
  $('.user').bind('change', function(){
    var size_in_megabytes = this.files[0].size/1024/1024;
    if (size_in_megabytes > 5) {
      alert('Maximum file size is 5MB. Please choose a smaller file.');
    }
  });

  // display uploaded image
  $("#user_avatar").change(function(){
    $('#avatar_img_prev').removeClass('hidden');
    $('.avatar_present_img').remove();
    readURL(this);
  });

  // infinite scroll for artists and albums index page
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

  // start/stop music
  $('i[data-play=playable-song]').click(function(){
    const object_id = $(this).data('id');

    $(`#sound-${object_id}`)[0].play();
    $(`#play-${object_id}`).hide();
    $(`#stop-${object_id}`).fadeIn();
  });

  $('i[data-play=stoppable-song]').click(function(){
    const object_id = $(this).data('id');

    $(`#sound-${object_id}`)[0].pause();
    $(`#sound-${object_id}`)[0].currentTime = 0;
    $(`#stop-${object_id}`).hide();
    $(`#play-${object_id}`).show();
  });

  // change icon when player ended
  $("audio").on("ended", function() {
    $(".fa-stop-circle").hide();
    $(".fa-volume-up").show();
  });

  // display rating stars
  $('.star-rating').raty({
    path: '/images/',
    readOnly: true,
    size: 6,
    half: true,
    score: function() {
      return $(this).attr('data-score');
    }
  });

  $('.review-submit').click(() => {
    const title = $('#review_title').val();
    const text = $('#review_text').val();
    let isTitleValid = true;
    let isTextValid = true;

    // front validation
    if (title === '') {
      $('#title-error').text('* Fill review title.');
      $('#title-error').show();
      isTitleValid = false;
    } else {
      $('#title-error').hide();
    }
    if (text === '') {
      $('#text-error').text('* Fill review text.');
      $('#text-error').show();
      isTextValid = false;
    } else {
      $('#text-error').hide();
    }

    if (isTitleValid === false || isTextValid === false) {
      return false;
    }

    $(this).css('pointer-events', 'none');
  });

  // slide down/up track lists
  $('.disc-number').each((e, v) => {
    $(v).next().hide();

    $(v).click(function() {
      const dataId = $(this).data('id');
      const targetClass = `.disc-${dataId}-tracks`;
      const chevronId = `#chevron-${dataId}`;

      let flg = $(targetClass).css('display') == "none";
      if(flg) {
        $(targetClass).slideDown();
        $(chevronId).toggleClass('fa-chevron-down fa-chevron-up');
      } else {
        $(targetClass).fadeOut();
        $(chevronId).toggleClass('fa-chevron-up fa-chevron-down');
      }
    });
  });
});
