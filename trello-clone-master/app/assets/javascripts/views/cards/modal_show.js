TrelloClone.Views.CardModalShow = Backbone.CompositeView.extend({
  initialize: function() {
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.model.items(), "add", this.render);
  },
  events: {
    "click .close": "closeWindow"
  },
  template: JST["cards/modal"],
  render: function() {
    this.$el.addClass("outer-modal");
    this.$el.html(this.template({ card: this.model }));
    this.model.items().each(function(item) {
      var view = new TrelloClone.Views.ItemView({ model: item });
      this.addSubview(".items", view);
    }.bind(this))
    return this;
  },

  closeWindow: function() {
    this.remove();
  }
})
