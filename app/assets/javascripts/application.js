// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require underscore
//= require gmaps/google
//= require foundation
//= require_tree .

var ready = function() {
  setTimeout(function(){ 
    $(function() { $(document).foundation(); }); 
  }, 500);
  if ($('div.alert.alert-notice').length ) {
    $('h4').remove();
  }
  if ($('div.alert.alert-error').length ) {
    $('h4').remove();
  }
  $('a#toggle').click(function() {
    $("div.googlemap").css("top", "190px");
  });
  $('a#title').click(function() {
    window.location = "http://seattle-alerts.herokuapp.com/";
  });
  $('input.button.submit').click(function() {
    $(function() { $(document).foundation(); }); 
  });
};

$(document).ready(ready);
$(document).on('page:load', ready);

