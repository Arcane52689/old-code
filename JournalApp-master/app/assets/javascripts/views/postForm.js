JournalApp.Views.PostForm = Backbone.View.extend({
  template: JST["posts/form"],
  events: {
    "submit form": "savePost"
  },


  render: function() {
    this.$el.html(this.template({
      post: this.model,
      errors: this.errors
    }));
    return this;
  },

  savePost: function(event) {

    event.preventDefault();
    var data = $(event.currentTarget).serializeJSON().post;
    this.model.set(data);
    this.model.save({}, {
      success: function() {
        this.collection.add(this.model, {merge: true});
        this.model = new JournalApp.Models.Post();
        this.render();
      }.bind(this),
      error: function(collection, response) {
        this.errors = response.responseText;
        this.render();
      }.bind(this)
    });
  }

})
