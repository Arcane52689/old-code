JournalApp.Routers.PostRouter = Backbone.Router.extend({
  routes: {
    '': 'postIndex',
    'posts/new': 'postForm',
    'posts/:id': 'postShow'
  },

  initialize: function(options) {
    this.content = options.content;
    this.sidebar = options.sidebar;
    this.views = {};
  },

  postIndex: function (callback) {
    this._indexView = this._indexView || new JournalApp.Views.PostIndex();
    this._indexView.refreshPosts( {
      success: callback
    });
    this.swapView(this._indexView, this.sidebar)
  },

  postShow: function (id) {
    if (!this._indexView) {
      this.postIndex( this.postShow.bind(this, id) );
    }
    else {
      var post = this._indexView.collection.getOrFetch(id);
      var showView = new JournalApp.Views.PostShow({
        model: post
      });
      this.swapView(showView, this.content)
    }
  },

  postForm: function() {
    var post = new JournalApp.Models.Post();
    if (!this._indexView) {
      this.postIndex( this.postForm.bind(this) )
    }
    else {
      var collection = this._indexView.collection;
      var form = new JournalApp.Views.PostForm( {
        model: post,
        collection: collection
      });
      this.swapView(form, this.content);
    }
  },

  swapView: function(newView, ctx) {
    if (this.views[ctx]) {
      this.views[ctx.attr("class")].remove();
    }
    this.views[ctx.attr("class")] = newView;
    ctx.html(newView.render().$el)
  }
});
