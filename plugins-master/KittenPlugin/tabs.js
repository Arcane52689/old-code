$.Carousel = function(el) {
  this.$el = $(el);
  this.$items = this.$el.find(".items");
  this.activeIndex = 0;
  this.$el.on("click", "a", this.addListeners.bind(this));
};

$.Carousel.prototype.addListeners = function (event) {
  var leftOrRight = $(event.currentTarget)
  if (leftOrRight.hasClass("slide-left")) {
    this.slide(1);
  }
  if (leftOrRight.hasClass("slide-right")) {
    this.slide(-1)
  }
};


$.Carousel.prototype.slide = function(dir) {
  if (this.activeIndex + dir < 0) {
    return;
  } else if (this.activeIndex + dir >= this.$items.find("li").length) {
    return;
  } else if ( this.transitioning) {
    return;
  }

  var newClassString = (dir === 1) ? "left" : "right";
  var oldClassString = (dir === 1) ? "right" : "left";


  var newIndex = this.activeIndex + dir;
  var newChild = this.$items.children().eq(newIndex);
  var oldChild = this.$items.children().eq(this.activeIndex);

  // oldChild.removeClass("active");
  oldChild.addClass(oldClassString);

  newChild.addClass("active");
  newChild.addClass(newClassString)
  this.activeIndex += dir;
  this.transitioning = true

  setTimeout(function() {
    this.transitioning = false;
    newChild.removeClass(newClassString);
    oldChild.one("transitionend", function() {
      oldChild.removeClass(oldClassString).removeClass("active");
    })
  }.bind(this))



};


$.fn.carousel = function () {
  return this.each(function () {
    new $.Carousel(this);
  });
};
