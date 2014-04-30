clearTable = function(){
  $('#chore-history').empty();
};

formatData = function(chore){
  var row = $('<tr>');
  var name = $('<td>').text(chore.name);
  var points = $('<td>').text(chore.points_value);
  var created_at = $('<td>').text(formatDate(chore.js_date * 1000));
  var comments = $('<td>').text(chore.comments);

  name.appendTo(row);
  points.appendTo(row);
  created_at.appendTo(row);
  comments.appendTo(row);
  return row;
};

appendDataToDom = function(dataArray){
  dataArray.forEach(function(chore){
    var _formattedData = formatData(chore);
    $('#chore-history').append(_formattedData);
  });
};

formatDate = function(date){
  var d = new Date(date);
  var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
  var month = months[d.getMonth()];
  var year = d.getFullYear();
  var day = d.getDate();
  return month + " " + day + ", " + year;
};


$(document).ready(function(){

  console.log("loaded bro");
  var user_email = $('.email-address').text();
  var lastWeekButton = $('#last-week-chores');
  var lastMonthButton = $('#last-month-chores');

  lastWeekButton.click(function(e){
    e.preventDefault();
    $.ajax({
      url: '/chores/lastweek',
      type: 'post',
      dataType: 'json',
      data: {user: user_email},
      success: function(data){
        // console.log(data);
        clearTable();
        appendDataToDom(data);
      },
      timeout: 15000 // timeout of ajax call
    });
  });

  lastMonthButton.click(function(e){
    e.preventDefault();
    $.ajax({
      url: '/chores/lastmonth',
      type: 'post',
      dataType: 'json',
      data: {user: user_email},
      success: function(data){
        // console.log(data);
        clearTable();
        appendDataToDom(data);
      },
      timeout: 15000 // timeout of ajax call
    });
  });


});
