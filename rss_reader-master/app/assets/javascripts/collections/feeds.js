NewsReader.Collections.Feeds = Backbone.Collection.extend({

  url: 'api/feeds',

  model: NewsReader.Models.Feed,

  getOrFetch: function(id) {
    if (this.get(id)) {
      var feed = this.get(id);
    } else {
      var feed = new this.model({id: id});
      this.add(feed);
    }

    feed.fetch();
    return feed;
  }

});
