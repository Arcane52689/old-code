$.Thumbnails = function(el) {
  this.$el = $(el);
  this.$gutter = $(this.$el.find(".gutter-images"));
  this.$figure = $(this.$el.find(".active-picture"));
  this.addImageTags();
}


$.Thumbnails.prototype.addImageTags = function () {
  var htmlFront = "<img class=\"thumbnail\" src=\"./images/";
  var htmlEnd = ".png\" >";
  for (var i = 1; i < 6; i++) {
    var html = htmlFront + "00" + i + htmlEnd;
    this.$gutter.append(html);
  }
}

$.Thumbnails.prototype.activate = function($img) {

}

$.fn.thumbnails = function () {
  return this.each(function () {
    new $.Thumbnails(this);
  });
};
