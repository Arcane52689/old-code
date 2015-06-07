JournalApp.Views.PostShow = Backbone.View.extend({
  template: JST["posts/show"],
  tagName: "article",
  events: {
    "dblclick p": "changeBody",
    "dblclick h1": "changeTitle",
    "blur textarea": "updateBody",
    "blur input": "updateTitle"
  },

  render: function() {
    this.$el.html(this.template({ post: this.model }));

    return this;
  },

  changeBody: function (event) {
    $(event.currentTarget).addClass("hidden")
    this.$el.find("textarea").removeClass("hidden")
  },

  changeTitle: function (event) {
    $(event.currentTarget).addClass("hidden")
    this.$el.find("input").removeClass("hidden")
  },

  updateBody: function (event) {
    var body = $(event.currentTarget).val();
    this.model.set("body", body);
    this.savePost();
  },

  updateTitle: function (event) {
    var title = $(event.currentTarget).val();
    this.model.set("title", title);
    this.savePost();
  },


  savePost: function() {
    this.model.save({}, {
      success: function() {
        this.render();
      }.bind(this)
    })
  }

})
