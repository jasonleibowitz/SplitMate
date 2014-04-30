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

  var blankApproval = $('<div class="vote-button"></div>');
  var approvedUp = $('<div class="vote-button"></div>');
  var approvedDown = $('<div class="vote-button"></div>');
  
	
  // make blankApproval!
  	// top button 
 	var up = $('<button>u</button>')
 	up.click({requestType: 'post', voteVal: '1'}, newUpApp);
  blankApproval.append(up);
  unvotes.append(blankApproval);
  	// bottom button
  		// to do


 // make approvedUp
 	// top button
 	var removeUpButton = $('<button>x</button>');
 	removeUpButton.click({requestType: 'delete', voteVal: '0'}, removeUpApp);
 	approvedUp.append(removeUpButton);
 	upvotes.append(approvedUp);
 			// to do
 	// bottom button
 			// to do
  

  });


function newUpApp (event) {

 var chore_history_id = $(this).parent().parent().attr('id');

	$.ajax({
		url: '/approvals',
		method: event.data.requestType,
		dataType: 'json',
		data: {
			approval: {
			chore_history_id: chore_history_id,
			value: event.data.voteVal
			}
		}
	}).done(function(data){
			// some kewl stuff
});   // end newUpApp
} // end newUpApp


function removeUpApp (event) {

	var chore_history_id = $(this).parent().parent().attr('id');

	$.ajax({
		url: '/approvals',
		method: event.data.requestType,
		dataType: 'json',
		data: {
			approval: {
			chore_history_id: chore_history_id,
			value: event.data.voteVal
			}
		}
	}).done(function(data){
		// some kewl stuff
		});   // end removeUpApp

}





$(function(){ $(document).foundation(); });
