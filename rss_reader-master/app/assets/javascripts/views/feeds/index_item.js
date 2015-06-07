NewsReader.Views.FeedsIndexItem = Backbone.View.extend({

  events: {
    "click .delete-feed": "deleteFeed"
  },

  template: JST["feeds/index_item"],

  tagName: "li",

  render: function() {
    this.$el.html(this.template({ feed: this.model }));
    return this;
  },

  deleteFeed: function() {
    this.model.destroy();
  }

});
