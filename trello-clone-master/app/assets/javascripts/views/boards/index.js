TrelloClone.Views.BoardsIndex = Backbone.CompositeView.extend({
  initialize: function() {
    this.listenTo(this.collection, "sync", this.render)
    this.collection.fetch()
  },

  template: JST["boards/index"],

  render: function() {
    this.$el.html(this.template({}));
    this.renderForm();

    this.collection.each(function(board){
      var view = new TrelloClone.Views.BoardIndexItem({ model: board });
      this.addSubview(".boards", view);
    }.bind(this))
    return this;
  },

  renderForm: function() {
    var view = new TrelloClone.Views.NewBoard({
      model:  new TrelloClone.Models.Board(),
      collection: this.collection
    });
    this.$el.addClass("boards-index")
    this.addSubview(".new-board", view)
  }

})
