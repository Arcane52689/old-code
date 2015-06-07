NewsReader.Views.EntryItem = Backbone.View.extend({

  template: JST["entries/entry_item"],

  tagName: "li",

  render: function() {
    var itemContent = this.template({entry: this.model});
    this.$el.html(itemContent);
    return this;
  }

});
