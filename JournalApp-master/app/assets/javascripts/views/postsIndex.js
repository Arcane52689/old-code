JournalApp.Views.PostIndex = Backbone.View.extend({
  template: JST["posts"],
  collection: new JournalApp.Collections.Posts(),

  initialize: function () {
    this.listenTo(this.collection, "sync remove", this.render);
  },

  render: function () {

    var content = this.template({posts: this.collection});
    this.$el.html(content);
    this.collection.each( function (post) {
      var item = new JournalApp.Views.PostIndexItem({
        model: post,
        collection: this.collection
      });
      item.render();
      this.$el.find(".posts").append(item.$el);
    }.bind(this));
    return this;
  },

  refreshPosts: function(options) {
    this.collection.fetch({
      success: function() {
        this.render();
        options.success && options.success();
    }.bind(this)
    })
  }
})
