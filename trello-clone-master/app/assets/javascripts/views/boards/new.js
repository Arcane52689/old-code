TrelloClone.Views.NewBoard = Backbone.View.extend({
  events: {
    "submit": "createBoard"
  },

  tagName: "form",

  template: JST["boards/new"],

  render: function() {
    this.$el.html(this.template());
    return this;
  },

  createBoard: function(event) {
    event.preventDefault();
    var data = this.$el.serializeJSON().board;
    this.model.set(data)
    this.model.save({}, {
      success: function() {
        this.collection.add(this.model)
        Backbone.history.navigate("boards/"+this.model.id, {trigger: true})
      }.bind(this)
    });
  }
})
