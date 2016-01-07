//= require jquery-2.1.4.min

DomElement = {
  matchingTerm: 'table.matching-term'
};

function clearAndHideResultTable() {
  var header = $('table.matching-term .header');
  $(DomElement.matchingTerm).html(header);
  $(DomElement.matchingTerm).hide();
}

function hideNoResults() {
  $('.no-results').hide();
}

function showNoResults(searchTerm) {
  $('.no-results').html('No results match "' + searchTerm + '"').show();
}

function showResultTable() {
  hideNoResults();
  $(DomElement.matchingTerm).show();
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

  return parents
}

function addToResultTable(result, searchTerms){
  showResultTable();
  var table = $('.matching-term');
  var lastChild = table.find('tr:last');

  $.each(searchTerms.split(' '), function(index, term) {
    if(term.length > 0 ) {
      $.each(result.find('td'), function(index, element) {
        if ($(element).find('span').length == 0){
          var existingHtml = $(element).html();
          var replacedHtml = existingHtml.replace(new RegExp("(" + term + ")", "i"), "<span class='highlighted'>$1</span>");
          $(element).html(replacedHtml);
        }
        else {
          $.each($('element').contents(), function(index, content) {
            if(content.nodeType == 3) {
              $(content).html($(content).html().replace(new RegExp("(" + term + ")", "i"), "<span class='highlighted'>$1</span>"));
            }
          });
        }
      });
    }
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
        showNoResults(searchTerm);
      }
    }
    else {
      hideNoResults();
      clearAndHideResultTable();
    }
  });
});
