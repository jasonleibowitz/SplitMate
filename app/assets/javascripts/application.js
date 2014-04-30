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

// ============== Blank Approval ========
  var blankApproval = $('<div class="vote-button"></div>');
    // make blankApproval
  	// top button 
 	var up = $('<button>u</button>')
 	up.click({requestType: 'post', voteVal: '1'}, newUpApp);
  blankApproval.append(up);
  	// bottom button
 	var down = $('<button>d</button>')
 	down.click({requestType: 'post', voteVal: '-1'}, newDownApp);
  blankApproval.append(down);
  unvotes.append(blankApproval);



// ============== Approved Up ========
  var approvedUp = $('<div class="vote-button"></div>');
  // make approvedUp
	 	// top button
 	var removeUpButton = $('<button>x</button>');
 	removeUpButton.click({requestType: 'delete', voteVal: '0'}, removeUpApp);
 	approvedUp.append(removeUpButton);
 	
	 	// bottom button
 	var switchDownButton = $('<button>sd</button>');
 	switchDownButton.click({requestType: 'put', voteVal: '-1'}, switchDownApp);
 	approvedUp.append(switchDownButton);
 	upvotes.append(approvedUp);
 

// ============== Approved Up ========
  var approvedDown = $('<div class="vote-button"></div>');
	// make approvedDown
		// top button
 	var switchUpButton = $('<button>+</button>');
 	switchUpButton.click({requestType: 'put', voteVal: '1'}, switchUpApp);
 	approvedDown.append(switchUpButton);

	 	// bottom button
	var removeDownButton = $('<button>r</button>');
 	removeDownButton.click({requestType: 'delete', voteVal: '0'}, removeDownApp);
 	approvedDown.append(removeDownButton);
 	downvotes.append(approvedDown);
  
	

  }); // end document.ready


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

	  var voteButtonsDiv = '#' + data.chore_history_id + ' .vote-button';
	  console.log("you just clicked upvote, let's build the right buttons, a remove up and switch down");
	  console.log($(voteButtonsDiv));
		$(voteButtonsDiv).empty();

		//removeUpApp button
		var removeUpButton = $('<button>x</button>');
	 	removeUpButton.click({requestType: 'delete', voteVal: '0'}, removeUpApp);
	 	$(voteButtonsDiv).append(removeUpButton);

		//switchDownApp button
	  var switchDown = $('<button>sd</button>');
	 	switchDown.click({requestType: 'put', voteVal: '-1'}, switchDownApp);
	   $(voteButtonsDiv).append(switchDown);	

	});   // end newUpApp
} // end newUpApp


function newDownApp (event) {

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

		//switch up button
			var theDiv = '#' + data.chore_history_id + ' .vote-button';
			var voteButtonsDiv = $(theDiv);
			voteButtonsDiv.empty();
			var switchUpButton = $('<button>+</button>');
			switchUpButton.click({requestType: 'put', voteVal: '1'}, switchUpApp);
			voteButtonsDiv.append(switchUpButton);

			//remove down button
			var removeDownButton = $('<button>r</button>');
	 		removeDownButton.click({requestType: 'delete', voteVal: '0'}, removeDownApp);
	 		voteButtonsDiv.append(removeDownButton);

	});   //end of .done newDownApp
} // end newDownApp


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
	}).done(function (data) {

	  var voteButtonsDiv = '#' + data.chore_history_id + ' .vote-button';
	  console.log("your callback thing is working bro");
	  console.log($(voteButtonsDiv));
		$(voteButtonsDiv).empty();

			// build a blankApproval
		var up = $('<button>u</button>');
	 	up.click({requestType: 'post', voteVal: '1'}, newUpApp);
	  $(voteButtonsDiv).append(up);

	  var down = $('<button>d</button>');
	 	down.click({requestType: 'post', voteVal: '-1'}, newDownApp);
	   $(voteButtonsDiv).append(down);	
		});   // end removeUpApp

} // end removeUpApp

function removeDownApp (event) {

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

	  var voteButtonsDiv = '#' + data.chore_history_id + ' .vote-button';
	  console.log("your callback thing is working bro");
	  console.log($(voteButtonsDiv));
		$(voteButtonsDiv).empty();

			// build a blankApproval
		var up = $('<button>u</button>');
	 	up.click({requestType: 'post', voteVal: '1'}, newUpApp);
	  $(voteButtonsDiv).append(up);

	  var down = $('<button>d</button>');
	 	down.click({requestType: 'post', voteVal: '-1'}, newDownApp);
	   $(voteButtonsDiv).append(down);	
		});  // end .done for removeDownApp 

} // end removeDownApp

function switchDownApp (event) {

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

	  var voteButtonsDiv = '#' + data.chore_history_id + ' .vote-button';
	  console.log("your callback thing is working bro");
	  console.log($(voteButtonsDiv));
		$(voteButtonsDiv).empty();

		// build a switch Up App
		var switchUpButton = $('<button>+</button>');
	 	switchUpButton.click({requestType: 'put', voteVal: '1'}, switchUpApp);
	 	$(voteButtonsDiv).append(switchUpButton);
		

	  // removeDown
		var removeDownButton = $('<button>r</button>');
	 	removeDownButton.click({requestType: 'delete', voteVal: '0'}, removeDownApp);
	 	$(voteButtonsDiv).append(removeDownButton);


		});  // end .done for removeDownApp 
} // end switchDownApp

function switchUpApp (event) {

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

	   var voteButtonsDiv = '#' + data.chore_history_id + ' .vote-button';
	  console.log("you just clicked upvote, let's build the right buttons, a remove up and switch down");
	  console.log($(voteButtonsDiv));
		$(voteButtonsDiv).empty();

		//removeUpApp button
		var removeUpButton = $('<button>x</button>');
	 	removeUpButton.click({requestType: 'delete', voteVal: '0'}, removeUpApp);
	 	$(voteButtonsDiv).append(removeUpButton);

		//switchDownApp button
	  var switchDown = $('<button>sd</button>');
	 	switchDown.click({requestType: 'put', voteVal: '-1'}, switchDownApp);
	   $(voteButtonsDiv).append(switchDown);


	});  // end .done for removeDownApp 
} //end of switchUppApp


$(function(){ $(document).foundation(); });
