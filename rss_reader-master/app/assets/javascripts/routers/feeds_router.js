NewsReader.Routers.FeedsRouter = Backbone.Router.extend({
  initialize: function(options) {
    this.collection = options.collection;
    this.collection.fetch();
  },

  routes: {
    "": "index",
    "feeds/:id": "showFeed"
  },

  index: function() {
    var indexView = new
     NewsReader.Views.FeedsIndex({
      collection: this.collection
    });
    this.swapView("#content", indexView);
  },

  showFeed: function(id) {
    var feed = this.collection.getOrFetch(id);
    var showView = new NewsReader.Views.FeedShow({ model: feed})
    this.swapView("#content", showView);
  },

  swapView: function(selector, view) {
    if (this._currentView) {
      this._currentView.remove();
    }

    this._currentView = view;
    $(selector).html(view.render().$el);
  }

});
