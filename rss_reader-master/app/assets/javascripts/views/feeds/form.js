NewsReader.Views.FeedForm = Backbone.View.extend({
  template: JST["feeds/form"],
  events: {
    "submit form": "createFeed"
  },

  render: function() {
    this.$el.html(this.template());
    return this;
  },

  createFeed: function(event) {
    event.preventDefault();
    var url = $(event.currentTarget).find("#url").val();
    this.model.set("url", url);
    this.model.save({},{
      success: function() {
        this.collection.add(this.model);
        event.currentTarget.reset();
      }.bind(this),

      error: function(model, response) {
        this.$el.find(".error").addClass("active");
      }.bind(this)
    });
  }
})
