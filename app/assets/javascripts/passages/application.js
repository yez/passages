//= require jquery-2.1.4.min

DomElements = {
  matchingTerm: 'table.matching-term'
};

function clearAndHideResultTable() {
  var header = $('table.matching-term .header');
  $(DomElements.matchingTerm).html(header);
  $(DomElements.matchingTerm).hide();
}

function hideNoResults() {
  $('.no-results').hide();
}

function showNoResults(searchTerm) {
  $('.no-results').html('No results match "' + searchTerm + '"').show();
}

function showResultTable() {
  hideNoResults();
  $(DomElements.matchingTerm).show();
}

function searchResults(query) {
  clearAndHideResultTable();
  var terms = query.split(' ');
  var parents = [];

  $.each(terms, function(index, el) {
    if (parents.length == 0) {
      parents = $('[data-search*=' + el + ']').parent('tr');
    }
    else if(el.length > 0) {
      $.each(parents, function(index, parent) {
        if($(parent).find($('[data-search*=' + el + ']')).length == 0) {
          parents[index] = null;
        }
      });
    }
  });

  if (query == 'users a') { debugger }

  return parents
}

function addToResultTable(result, searchTerms){
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
          addToResultTable($(value).clone(), searchTerm);
        });
      }
      else {
        showNoResults(searchTerm);
      }
    }
    else {
      hideNoResults();
      clearAndHideResultTable();
    }
  });
});
