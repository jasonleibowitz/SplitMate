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
$(document).ready(function () {

  console.log("loaded broseph");

  var upvotes = $('.upvoted');
  var downvotes = $('.downvoted');
  var unvotes = $('.unvoted');



  var unvote_form_up = $('<div class="vote-button"></div>');
  
	
 
 	var up = $('<button>').val('up');
 	up.click(createNewUpApproval);

  unvote_form_up.append(up);
  
  unvotes.append(unvote_form_up);
  

  });


function createNewUpApproval() {

	 var chore_history_id = $(this).parent().parent().attr('id');
	
		$.ajax({
			url: '/approvals',
			method: 'post',
			dataType: 'json',
			data: {
				approval: {
				chore_history_id: chore_history_id,
				value: '1'
				}
			}
		}).done(function(data){
			 console.log(data);
		});

};

$(function(){ $(document).foundation(); });
