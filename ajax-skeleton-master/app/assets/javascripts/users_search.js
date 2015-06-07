$.UsersSearch = function (el) {
  this.$el = $(el);
  this.$searchField = $(this.$el.find("#users-query"));
  this.$userList = $(this.$el.find(".users-list"));
  this.$searchField.on("input", this.handleInput.bind(this));
  this.makeTemplate();
};




$.UsersSearch.prototype.handleInput = function() {
  this.$userList.empty()
  var input = this.$searchField.val();
  console.log(input)
  $.ajax({
    url: "/users/search",
    dataType: "json",
    data: {"query":input},
    success: function(response) {
      console.log(response);
      this.addUsers(response);
    }.bind(this)
  })
};

$.UsersSearch.prototype.makeTemplate = function() {
  var templateString = "<li><a href=\"users/<%=id%>\"><%=username%></a><button id=\"follow-button\" class=\"follow-toggle\"></button></li>"
  this.templateFn = _.template(templateString);
};


$.UsersSearch.prototype.addUsers = function(response) {
  response.forEach(this.addUser.bind(this))
};

$.UsersSearch.prototype.addUser = function(user) {

  var followState = (user.followed) ? "unfollow" : "follow";
  var userOptions = { "followState": followState, "userId": user.id };
  var htmlString = this.templateFn( { id: user.id, username: user.username } )
  this.$userList.append(htmlString);

  var $li = $(this.$userList.find(":last-child"))
  var $button = $($li.find("#follow-button"))
  $button.followToggle(userOptions)
};




$.fn.usersSearch = function () {
  return this.each(function() {
    new $.UsersSearch(this);
  });
};

$(function() {
  $(".users-search").usersSearch();
});
