TrelloClone.Collections.Cards = Backbone.Collection.extend({
  url: "api/cards",
  model: TrelloClone.Models.Card,
  comparator: function(card) {
    return card.get("ord");
  },

  assignOrder: function() {
    var i = 0
    this.each( function(card) {
      card.save({ord: i});
      i += 1;
    })
  }
})
