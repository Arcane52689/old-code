TrelloClone.Routers.BoardsRouter = Backbone.Router.extend({
  initialize: function(options) {
    this.$rootEl = options.$rootEl;
  },
  routes: {
    "": "index",
    "boards/:id": "show"
  },

  index: function() {
    var view = new TrelloClone.Views.BoardsIndex({
      collection: TrelloClone.Collections.boards
    });
    this._swapView(view)


  },

  show: function(id) {
    var board = TrelloClone.Collections.boards.getOrFetch(id);
    var view = new TrelloClone.Views.BoardShow({
      model: board
    });
    this._swapView(view)
  },

  _swapView: function(view) {
    if (this._currentView) {
      this._currentView.remove();
    }
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  }



})
