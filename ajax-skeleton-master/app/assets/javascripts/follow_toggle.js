$.FollowToggle = function (el, options) {
  this.$el = $(el);
  this.data = this.$el.data();
  this.userId = this.data["userId"] || options.userId
  this.followState = this.data["initialFollowState"] || options.followState;
  this.setButton();
  this.$el.on("click", this.toggle.bind(this));
};

$.FollowToggle.prototype.toggle = function(event) {
  event.preventDefault();
  if (this.followState === "follow") {
    this.makeFollow();
  } else {
    this.makeUnfollow();
  }
};

$.FollowToggle.prototype.makeFollow = function() {

  $.ajax({
    url: "/users/" + this.userId + "/follow/",
    type: "POST",
    dataType: "json",
    success: function () {
      this.swap();
    }.bind(this)
  });
};

$.FollowToggle.prototype.makeUnfollow = function() {
  $.ajax({
    url: "/users/" + this.userId + "/follow/",
    type: "DELETE",
    dataType: "json",
    success: function () {
      this.swap();
    }.bind(this)
  });
};

$.FollowToggle.prototype.swap = function() {
  this.followState = (this.followState === "follow") ? "unfollow" : "follow";
  this.setButton();
};

$.FollowToggle.prototype.setButton = function() {
  this.$el.empty();
  this.$el.append(this.followState);
};


$.fn.followToggle = function (options) {
  return this.each(function () {
    new $.FollowToggle(this, options);
  });
};


$(function () {
  $("button.follow-toggle").followToggle();
});
