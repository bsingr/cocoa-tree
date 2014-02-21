window.load_categories = function(){
  var categories = {
    "xml": [],
    "json": [],
    "api": [],
    "http": [],
    "string": [],
    "md5": [],
    "sha1": [],
    "hmac": [],
    "url": [],
    "ui": [],
    "network": [],
    "ipad": [],
    "ios": [],
    "iphone": [],
    "mac": [],
    "osx": [],
    "image": [],
    "view": [],
    "calendar": [],
    "csv": [],
    "navigation": []
  };
  var categoryForName = function(name) {
    for (var categoryName in categories) {
      if (name.match(categoryName)) {
        return categories[categoryName]
      }
    }
    return false;
  };

  var wordStats = {};
  var wordList = [];
  $('.pod .summary').each(function(){
    var element = $(this).parents('.pod').first().get(0);
    var words = $(this).text().replace(/\.$/, '').split(' ');
    for(var i=0; i<words.length; i++) {
      var word = words[i].toLowerCase();
      if (word.length > 2) {
        var category = categoryForName(word);
        if (category) {
          category.push(wordStats[word]);
        }
        if (wordStats[word] == undefined) {
          wordStats[word] = {"word": word, "count": 0, "elements": []};
          wordList.push(wordStats[word]);
        }
        wordStats[word].count += 1;
        wordStats[word].elements.push(element);
      }
    }
  });

  var categoriesHtml = [];
  for (var categoryName in categories) {
    var categoryData = categories[categoryName];
    categoriesHtml.push("<a href='#!/filter/"+categoryName+"'>"+categoryName+" "+categoryData.length+"</a>");
  }
  $('.categories').html(categoriesHtml.join(' '));

  var sortedWordList = wordList.sort(function(a,b){return b.count-a.count});
  var html = [];
  for (var i = 0; i < 100; i++) {
    var stats = sortedWordList[i];
    if (stats) {
      html.push("<a href='#!/filter/"+stats.word+"'>"+stats.word+"</a>");
    }
  }
  $('.tags').html(html.join(' '));

  $('.categories, .tags').on('click', 'a', function(){
    var word = $(this).attr('href').replace('#!/filter/', '');
    $('.pod').hide();
    var stats = wordStats[word];
    $(wordStats[word].elements).show();
  });
};
