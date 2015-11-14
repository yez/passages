function clearAndHideResultTable() {
  var header = $('table.matching-term .header');
  $('table.matching-term').html(header);
  $('table.matching-term').hide();
}

function hideNoResults() {
  $('.no-results').hide();
}

function showNoResults() {
  $('.no-results').show();
}

function showResultTable() {
  hideNoResults();
  $('table.matching-term').show();
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
      hideNoResults();
      var results = searchResults(searchTerm.toLowerCase());
      if (results.length > 0) {
        $.each(results, function(index, value){
          addToResultTable($(value).clone());
        });
      }
      else {
        showNoResults();
      }
    }
    else {
      hideNoResults();
      clearAndHideResultTable();
    }
  });
});
