TrelloClone.Views.CardItem = Backbone.View.extend({
  events: {
    "click .delete": "destroyCard",
    // "dblclick .card-title": "swapTitle",
    // "dblclick .card-description": "swapDescription"
    // "dblclick": "showOrder"
    "dblclick": "modalView"
  },
  tagName: "li",
  template: JST["cards/card_item"],
  render: function() {
    this.$el.html(this.template({card:this.model}));
    this.$el.addClass("card-container");
    this.$el.attr("data-card-id", this.model.id+"");
    this.$el.attr("id","card_"+this.model.get("ord"));
    return this;
  },

  destroyCard: function(event) {
    debugger
    event.preventDefault();
    this.model.destroy();
    this.remove();
  },

  swapTitle: function() {
    this.$el.find(".card-title").toggleClass("inactive");
    var newVal = this.$el.find(".input").val();

    if (newVal !== this.model.get("title")) {
      this.model.save({title: newVal }, {
        success: function() {
          this.render()
        }.bind(this)
      })
    }
  },
  swapDescription: function() {
    this.$el.find(".card-description").toggleClass("inactive");
    var newVal = this.$el.find(".textarea").val();
    if (newVal !== this.model.get("description")) {
      this.model.save({description: newVal }, {
        success: function() {
          this.render();
        }.bind(this)
      })
    }
  },

  showOrder: function() {
    console.log(this.model.get("ord"));
  },

  modalView: function() {
    this.model.fetch();
    var view = new TrelloClone.Views.CardModalShow({
      model: this.model
    });
    $("#main").append(view.render().$el);
  }

})
