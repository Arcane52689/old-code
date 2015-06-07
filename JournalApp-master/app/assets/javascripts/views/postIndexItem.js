JournalApp.Views.PostIndexItem = Backbone.View.extend({
  template: JST["posts/indexItem"],
  tagName: "li",
  events: {
    "click .delete": 'deletePost'
  },
  render: function () {
    this.$el.html(this.template({post: this.model}));
  },

  deletePost: function (event) {
    event.preventDefault();
    this.model.destroy({
      success: function() {
        this.collection.remove(this.model);
        this.remove();
      }.bind(this)
    })
  }
})
