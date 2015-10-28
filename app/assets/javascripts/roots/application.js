$(document).on('ready', function(){
  $('input[name=search]').keyup(function(event){
    var searchTerm = event.target.value;
    if(searchTerm.length > 0){
      searchResults(searchTerm);
    }
  });
});

function clearBackground(){
  $('td').css('background-color', 'white');
}

function searchResults(query) {
  clearBackground();
  var matches = {};
  $.each($('[data-search*=' + query), function(index, value) {
    $(value).css('background-color', 'yellow');
  });
}


