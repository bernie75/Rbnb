//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require jquery-fileupload/basic
//= require cloudinary/jquery.cloudinary
//= require attachinary
//= require underscore
//= require gmaps/google
//= require_tree .

$('#star-rating').raty({
  path: '/assets/',
  scoreName: 'review[rating]'
});

$('.star-rating').raty({
  path: '/assets/',
  readOnly: true,
  score: function() {
    return $(this).attr('data-score');
  }
});
