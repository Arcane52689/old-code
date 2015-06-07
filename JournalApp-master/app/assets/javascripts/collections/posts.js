JournalApp.Collections.Posts = Backbone.Collection.extend({
  url: "/posts",
  model: JournalApp.Models.Post,


  getOrFetch: function(id) {
    if (!this.get(id)) {
      var post = new this.model({id: id});
      post.fetch({
        success: function () {
          this.add(post);
        }.bind(this)
      });
    } else {
      var post = this.get(id);
    }

    return post;
  }
})
