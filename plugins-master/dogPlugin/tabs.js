$.Tabs = function (el) {
  this.$el = $(el);
  this.$contentTabs = $("#"+this.$el.data("content-tabs"));
  this.$tabPanes = $(this.$contentTabs.find("tab-pane"));
  this.$activeTab = $(this.$contentTabs.find(".active-pane"));
  this.$activeLink = $(this.$el.find(".active-link"));
  this.$el.on("click","a", this.clickTab.bind(this));
};

$.Tabs.prototype.clickTab = function(event) {
  if (this.transitioning) {
    return;
  }

  this.transitioning = true;

  event.preventDefault();


  this.$activeLink.removeClass("active-link");
  this.$activeLink = $(event.currentTarget);
  this.$activeLink.addClass("active-link");

  var tabName = this.$activeLink.attr('href');
  var $newActiveTab = $(this.$contentTabs.find(tabName));

  this.$activeTab.removeClass("active-pane");
  this.$activeTab.addClass("transitioning");
  this.$activeTab.one("transitionend", function(){
    this.$activeTab.removeClass("transitioning");
    this.$activeTab = $newActiveTab;
    this.$activeTab.addClass("transitioning");
    setTimeout(function() {
      this.$activeTab.removeClass("transitioning");
      this.$activeTab.addClass("active-pane");
      this.transitioning = false;
    }.bind(this))
  }.bind(this));
};







$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};
