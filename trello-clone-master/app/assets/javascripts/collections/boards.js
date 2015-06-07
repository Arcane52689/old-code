TrelloClone.Collections.Boards = Backbone.Collection.extend({
  url: "api/boards",
  model: TrelloClone.Models.Board,

  getOrFetch: function(id) {
    var model = this.get(id);
    if (!model) {
      model = new this.model({id: id});
      this.add(model)
    }
    model.fetch();
    return model;
  }
})
