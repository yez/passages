function clearAndHideResultTable() {
  $('table.matching-term').html('');
  $('table.matching-term').css('display', 'none');
}

function showResultTable() {
  $('table.matching-term').css('display', '');
}

function searchResults(query) {
  clearAndHideResultTable();
  var found = $('[data-search*=' + query).parent('tr');
  return found;
}

function addToResultTable(result){
  showResultTable();
  var table = $('.matching-term');
  var lastChild = table.find('tr:last');
  if(lastChild.length == 0) {
    table.html(result);
  }
  else {
    lastChild.after(result);
  }
}

$(document).on('ready', function(){
  $('input[name=search]').keyup(function(event){
    var searchTerm = event.target.value;
    if(searchTerm.length > 0) {
      var results = searchResults(searchTerm.toLowerCase());
      $.each(results, function(index, value){
        addToResultTable($(value).clone());
      });
    }
    else {
      clearAndHideResultTable();
    }
  });
});
