TrelloClone.Views.AreYouSure = Backbone.View.extend({
  initialize: function(options) {
    this.text = options.text;
    this.callback = options.callback
  },

  template: JST["are_you_sure"],

  events: {
    "click button": "answer"
  },

  render: function() {
    this.$el.addClass("sure-outer")
    this.$el.html(this.template({text: this.text }));
    return this;
  },

  answer: function(event) {
    event.preventDefault();
    var response = $(event.currentTarget).attr("id")
    if (response === "yes") {
      this.callback();
    }
    this.remove();
  }
})
