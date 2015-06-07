TrelloClone.Views.ItemView = Backbone.View.extend({
  tagName: "li",
  template: JST["items/item"],
  render: function() {
    this.$el.addClass("item-item");
    this.$el.html(this.template({item: this.model}));
    return this;
  }
})
