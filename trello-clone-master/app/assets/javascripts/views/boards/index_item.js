TrelloClone.Views.BoardIndexItem = Backbone.View.extend({
  events: {
    "click .delete": "areYouSure"
  },
  template: JST["boards/index_item"],
  render: function() {
    this.$el.html(this.template({board:this.model}));
    this.$el.addClass("board-item");
    return this;
  },

  deleteBoard: function() {
    this.model.destroy();
    this.remove();
  },

  areYouSure: function() {
    var view = new TrelloClone.Views.AreYouSure({
      text: "Are you sure you want to delete this board",
      callback: this.deleteBoard.bind(this)
    });
    $("#main").append(view.render().$el);
  }
})
