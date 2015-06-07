TrelloClone.Collections.Items = Backbone.Collection.extend({
  url: "/api/items",
  model: TrelloClone.Models.Item
})
