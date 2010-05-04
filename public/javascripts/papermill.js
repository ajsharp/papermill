$(document).ready(function() {
  $('.add-search-param').click(function(event) {
    var newEl = $('#hidden-param').clone().appendTo('#papermill-search #search-params');
    newEl.addClass('search-param');
    newEl.removeAttr('id');
    newEl.slideDown(200, function() { newEl.removeClass('no-show'); });
    return false;
  });

  $('.remove-search-param').live('click', function(event) { 
    var el = $(this).parents('.search-param');
    el.fadeOut(200, function() {
      el.remove();
    })
  });

  $('#papermill-search').submit(function(event) {
    $("#ajax-loader").removeClass('no-show');
    $('#search-results').load(this.action, $(this).serialize(), function() {
      $("#ajax-loader").addClass('no-show');
    });
    return false;
  });
})

