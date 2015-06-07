NewsReader.Views.FeedsIndex = Backbone.CompositeView.extend({

  initialize: function() {
    this.listenTo(this.collection, "sync remove", this.render);
  },

  template: JST["feeds/index"],

  render: function() {
    this.$el.html(this.template());
    this.collection.each(function(feed){
      var indexItem = new NewsReader.Views.FeedsIndexItem({
        model: feed,
        collection: this.collection
      });
      this.addSubview(".feeds", indexItem, true);
    }.bind(this));
    this.renderForm();
    return this;
  },

  renderForm: function() {
    var formView = new NewsReader.Views.FeedForm({
      model: new NewsReader.Models.Feed(),
      collection: this.collection
    })
    this.addSubview(".form", formView);
  }

});
