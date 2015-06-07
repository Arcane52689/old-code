TrelloClone.Views.NewCard = Backbone.View.extend({


  events: {
    "click .cancel": "cancel",
    "submit form": "createCard"
  },
  template: JST["cards/new"],

  render: function() {
    this.$el.html(this.template({ card: this.model }));
    this.$el.addClass("new-card")
    return this;
  },

  createCard:function(event) {
    event.preventDefault();
    var data = $(event.currentTarget).serializeJSON().card;
    this.model.set('ord', this.collection.length);
    this.model.save(data, {
      success: function() {
        this.collection.add(this.model);
        this.remove()
      }.bind(this)
    });
  },
  cancel: function(event) {
    event.preventDefault();
    this.remove();
  }
})
