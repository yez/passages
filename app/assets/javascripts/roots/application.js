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

function showNoResults() {
  $('.no-results').show();
}

function showResultTable() {
  hideNoResults();
  $(DomElements.matchingTerm).show();
}

function searchResults(query) {
  clearAndHideResultTable();
  return $('[data-search*=' + query).parent('tr');
}

function highlight(element, term) {
  var existing = $(element).html();
  var bolded = existing.replace(new RegExp("(" + term + ")", "i"), "<span class='highlighted'>$1</span>");
  $(element).html(bolded)
}

function addToResultTable(result, searchTerm){
  showResultTable();
  var table = $('.matching-term');
  var lastChild = table.find('tr:last');

  $.each(result.children(), function(index, element) {
    highlight(element, searchTerm);
  });

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
        showNoResults();
      }
    }
    else {
      hideNoResults();
      clearAndHideResultTable();
    }
  });
});
