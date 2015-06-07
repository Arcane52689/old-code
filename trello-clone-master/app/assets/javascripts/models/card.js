TrelloClone.Models.Card = Backbone.Model.extend({
  urlRoot: "api/cards",

  items: function() {
    if (!this._items){
      this._items = new TrelloClone.Collections.Items();
    }
    return this._items;
  },

  parse: function(response) {
    this.items().set(response.items);
    delete response.items;
    return response;
  }

})
