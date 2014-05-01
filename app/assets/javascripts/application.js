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
//= require foundation
//= require_tree .
//= require jquery.ui.all
$(document).ready(function () {

  console.log("loaded broseph");

$(function() {
    $( ".draggable" ).draggable();
    $( ".droppable" ).droppable({
      drop: function( event, ui ) {
        var roommate_div = $(this);
        $.ajax({
          url: '/dropchore',
          method: 'put',
          data: {
            chore_id: ui.draggable.attr('id'),
            user_id: $(this).attr('id')
          },
          dataType: 'script'
        }).done(function(data) {
        console.log(data);
       ui.draggable.empty();
       roommate_div.append("Chore Assigned!");
       roommate_div.parent().addClass("chore-dropped");
       console.log('you dropped chore: ' + ui.draggable.attr('id'));
       console.log('onto this user: ' + roommate_div.attr('id'));

        }); // end .done

      } //idk what this is
    });
  });

});


$(function(){ $(document).foundation(); });
