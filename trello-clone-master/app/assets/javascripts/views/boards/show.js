TrelloClone.Views.BoardShow = Backbone.CompositeView.extend({
  initialize: function() {
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.model.lists(), "add", this.render);

  },

  template: JST["boards/show"],
  render: function() {
    this.$el.html(this.template({ board: this.model }));
    this.model.lists().each(function(list) {
      var view = new TrelloClone.Views.ListItem({
        model: list,
        board: this.model
      });
      this.addSubview(".lists", view)
    }.bind(this));
    this.$el.addClass("board group")
    this.renderForm();

    return this;
  },

  renderForm: function() {
    var list = new TrelloClone.Models.List();
    list.set("board_id", this.model.id);
    var view = new TrelloClone.Views.NewList({
      model: list,
      collection: this.model.lists()
    });
    this.bindSortable();
    this.addSubview(".new-list-container",view)
  },


  bindSortable: function() {
    this.$el.find(".lists").sortable({
      stop: this.reorder.bind(this)
    }).disableSelection();

  },

  reorder: function() {
    this.$el.find(".lists").children().each(function(order, li){
      var list = this.model.lists().get($(li).data("list-id"));
      if (list.get("ord") !== order){
        list.set("ord", order)
        list.save();
      }
    }.bind(this))
  }


})
