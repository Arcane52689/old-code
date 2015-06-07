$.TweetCompose = function(el) {
  this.$el = $(el);
  this.makeTweetTemplate();
  this.makeMentionedTemplate();

  this.$textArea = this.$el.find("textarea");
  this.$charLimit = this.$el.find(".chars-left");
  this.$ul = $(this.$el.data()["tweetsUl"]);
  this.$addSelectLink = this.$el.find(".add-mentioned-users");
  this.$mentionedUsers = this.$el.find(".mentioned-users");
  this.$inputs = this.$el.find(":input");

  this.$el.on("submit", this.submitTweet.bind(this));
  this.$textArea.on("input", this.updateCharLimit.bind(this));
  this.$addSelectLink.on("click", this.addSelectTag.bind(this));
}

$.TweetCompose.prototype.submitTweet = function(event) {
  event.preventDefault();
  $.ajax({
    url: "/tweets",
    type: "POST",
    data: this.$el.serialize(),
    dataType: "json",
    success: this.handleSuccess.bind(this)
  });
  this.disableInputs();
};

$.TweetCompose.prototype.updateCharLimit = function() {
  var val = this.$textArea.val();
  var count = 140 - val.length;
  this.$charLimit.empty();
  this.$charLimit.append(count);
};


$.TweetCompose.prototype.handleSuccess = function(response) {
  console.log(response)
  this.enableInputs();
  this.clearInput();
  var html = this.tweetTemplateFn({
    content: response.content,
    id: response.user_id,
    time: response.created_at
  });

  if (response.mentions.length > 0) {
    html += this.addMentionedUsers(response.mentions)
  }
  html += "</li>"
  this.$ul.prepend(html);
  this.updateCharLimit();
  this.$mentionedUsers.empty();
}


$.TweetCompose.prototype.addSelectTag = function() {
  var html = this.$el.find("script").html();
  this.$mentionedUsers.prepend(html);
}

$.TweetCompose.prototype.addMentionedUsers = function(mentions) {
  var html = "<ul class=\"mentioned\">";
  mentions.forEach( function(mention) {
    html += this.mentionedTemplateFn({ mentioned_id: mention.user.id, mentioned_name: mention.user.username });
  }.bind(this))
  html += "</ul>";
  return html;
}


$.TweetCompose.prototype.disableInputs = function () {
  this.$inputs.prop("disabled", true);
};

$.TweetCompose.prototype.enableInputs = function () {
  this.$inputs.prop("disabled", false);
};


$.TweetCompose.prototype.clearInput = function() {
  this.$el[0].reset();
}


$.TweetCompose.prototype.makeTweetTemplate = function() {
  var templateString = "<li><%= content %>--<a href=\"/users/<%= id %>\">hi</a> -- <%= time %>" // Will have to append </li> to template string
  this.tweetTemplateFn = _.template(templateString);
};

$.TweetCompose.prototype.makeMentionedTemplate = function() {
  var templateString = "<li><a href=\"/users/<%=mentioned_id%>\" ><%=mentioned_name%></a></li>";
  this.mentionedTemplateFn = _.template(templateString);
}



$.fn.tweetCompose = function() {
  return this.each(function() {
    new $.TweetCompose(this);
  });
};

$(function() {
  $(".tweet-compose").tweetCompose();
});
