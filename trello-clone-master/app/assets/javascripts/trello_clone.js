window.TrelloClone = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    // alert("Hello from Backbone!");
    this.router = new TrelloClone.Routers.BoardsRouter({
      $rootEl: $("#main")
    })
    TrelloClone.Collections.boards = new TrelloClone.Collections.Boards()
    Backbone.history.start();
  }
};

$(document).ready(function(){
  TrelloClone.initialize();
});
