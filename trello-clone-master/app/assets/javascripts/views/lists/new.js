TrelloClone.Views.NewList = Backbone.View.extend({
  events: {
    "submit": "createList"
  },

  tagName: "form",

  template: JST["lists/new"],

  render: function() {
    this.$el.html(this.template());
    this.$el.addClass("new-form");
    return this;
  },

  createList: function(event) {
    event.preventDefault();
    var data = this.$el.serializeJSON().list
    this.model.set(data)
    this.model.set("ord",this.collection.length);
    this.model.save({}, {
      success: function() {
        this.collection.add(this.model);
        this.$el[0].reset();
      }.bind(this),
    })
  }
})
