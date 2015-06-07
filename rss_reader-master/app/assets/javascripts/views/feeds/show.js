NewsReader.Views.FeedShow = Backbone.CompositeView.extend({

  events: {
    "click .refresh": "refreshEntries",
    "click li": "renderLinkedContent"
  },

  initialize: function() {
    this.listenTo(this.model, "sync", this.render);
  },

  template: JST["feeds/show"],

  refreshEntries: function() {
    this.model.fetch();
  },

  render: function() {
    this.$el.html(this.template({ feed: this.model }));
    this.model.entries().each(function(entry){
      var entryView = new NewsReader.Views.EntryItem({ model: entry });
      this.addSubview(".entries", entryView, true);
    }.bind(this));
    return this;
  },

  renderLinkedContent(event) {
    event.preventDefault();
    var link = $(event.currentTarget).find("a").attr('href');
    var obj = '<object data="' + link + '" type="text/html"></object>';
    $(".other-content").html(obj);
  }

});
