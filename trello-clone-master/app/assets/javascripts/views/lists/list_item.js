TrelloClone.Views.ListItem = Backbone.CompositeView.extend({
  initialize: function(options) {
    this.board = options.board;
    this.listenTo(this.model.cards(), "add", this.render);
  },
  events: {
    "click .new-card-button":"renderForm",
    "click .delete":"destroySelf"
  },
  tagName: "li",
  template: JST["lists/listItem"],
  render: function() {
    this.$el.html(this.template({list: this.model}));
    this.model.cards().each(function(card){
      var view = new TrelloClone.Views.CardItem({model: card });
      this.addSubview(".cards", view);
    }.bind(this));
    this.$el.addClass("list group")
    this.$el.attr("data-list-id",this.model.id+"");
    this.$el.find(".cards").data("list-id",this.model.id+"")
    this.bindDragging()
    return this;
  },

  renderForm: function(event) {
    event.preventDefault();
    var card = new TrelloClone.Models.Card()
    card.set("list_id", this.model.id);
    var view = new TrelloClone.Views.NewCard({
      model: card,
      collection: this.model.cards()
    })
    this.addSubview(".cards", view);
  },

  bindDragging: function(){
    this.$el.find(".cards").sortable({
      connectWith: ".cards",
      receive: this.addCard.bind(this),
      remove: this.reorder.bind(this),
      stop: this.reorder.bind(this)
    }).disableSelection();
  },




  addCard: function(event, ui) {
    var cardId = ui.item.data("card-id");
    var senderId = ui.sender.data("list-id");
    var oldList = this.board.lists().get(senderId);
    var card = oldList.cards().get(cardId);
    card.set("list_id",this.model.id);
    card.save({},
    {
      success: function() {
        this.model.cards().add(card, {silent: true});
        oldList.cards().remove(card);
        this.reorder();
      }.bind(this)
    })
  },






  destroySelf: function() {
    while (this.model.cards().length > 0) {
      var card = this.model.cards().pop();
      card.destroy();
    }
    this.model.destroy();
    this.remove();
  },

  reorder: function() {
    this.$el.find(".cards").children().each(function(order, li){

      var card = this.model.cards().get($(li).data("card-id"));
      if (card.get("ord") !== order){
        card.set("ord", order)
        card.save();
      }
    }.bind(this))
  }

})
