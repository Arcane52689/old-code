TrelloClone.Models.Board = Backbone.Model.extend({
  urlRoot: "api/boards",
  lists: function() {
    if (!this._lists) {
      this._lists = new TrelloClone.Collections.Lists();
    }
    return this._lists
  },

  parse: function(response) {
    if (response.lists) {
      response.lists.forEach(function(list) {
        list_model = new TrelloClone.Models.List(list)
        list_model.cards().set(list.cards)
        this.lists().add(list_model)
      }.bind(this))
    }
    return response;
  }
})
