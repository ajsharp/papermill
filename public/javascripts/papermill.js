var Papermill = {};

var top10Graph = {
  initialize: function() {
    $('#refresh-stats').click();
  },

  refresh: function(values, labels) {
    $("#graph").html('');
    var r = Raphael("graph");
    r.g.txtattr.font = "12px 'Fontin Sans', Fontin-Sans, sans-serif";
    
    r.g.text(320, 100, "Most Requested Actions").attr({"font-size": 20});
    
    var pie = r.g.piechart(320, 240, 100, values, { legend: labels, legendpos: "west" });

    pie.hover(function () {
        this.sector.stop();
        this.sector.scale(1.1, 1.1, this.cx, this.cy);
        if (this.label) {
            this.label[0].stop();
            this.label[0].scale(1.5);
            this.label[1].attr({"font-weight": 800});
        }
    }, function () {
        this.sector.animate({scale: [1, 1, this.cx, this.cy]}, 500, "bounce");
        if (this.label) {
            this.label[0].animate({scale: 1}, 500, "bounce");
            this.label[1].attr({"font-weight": 400});
        }
    });
  }
};

Papermill.handlers = {
  addSearchParam: function(event) {
    var newEl = $('#hidden-param').clone().appendTo('#papermill-search #search-params');
    newEl.addClass('search-param');
    newEl.removeAttr('id');
    newEl.slideDown(200, function() { newEl.removeClass('no-show'); });
    return false;
  },

  removeSearchParam: function(event) {
    var el = $(this).parents('.search-param');
    el.fadeOut(200, function() { el.remove(); });
  },

  search: function(event) {
    var that = $(this);
    that.children(".ajax-loader").removeClass('no-show');
    $('#search-results').load(this.action, $(this).serialize(), function() {
      that.children(".ajax-loader").addClass('no-show');
    });
    return false;
  },

  refreshStats: function(event) {
    var that = $(this);
    that.siblings(".ajax-loader:first").removeClass('no-show');
    that.hide();

    $.getJSON(this.href, null, function(data) {
      var values = $(data).map(function() { return this.value.count; });
      var labels = $(data).map(function() { return this._id + ' - %%.%%'; });

      top10Graph.refresh(values, labels);

      that.show();
      that.siblings(".ajax-loader:first").addClass('no-show');
    });
    return false;
  }
}

$(document).ready(function() {
  $('.add-search-param').click(Papermill.handlers.addSearchParam);
  $('.remove-search-param').live('click', Papermill.handlers.removeSearchParam);
  $('#papermill-search').submit(Papermill.handlers.search);
  $('#refresh-stats').click(Papermill.handlers.refreshStats);

  top10Graph.initialize();
})

