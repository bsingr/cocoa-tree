$(document).ready(function(){
  var wordStats = {};
  var wordList = [];
  $('.pod .summary').each(function(){
    var element = $(this).parents('.pod').first().get(0);
    var words = $(this).text().replace(/\.$/, '').split(' ');
    for(var i=0; i<words.length; i++) {
      var word = words[i];
      if (word.length > 2) {
        if (wordStats[word] == undefined) {
          wordStats[word] = {"word": word, "count": 0, "elements": []};
          wordList.push(wordStats[word]);
        }
        wordStats[word].count += 1;
        wordStats[word].elements.push(element);
      }
    }
  });

  var sortedWordList = wordList.sort(function(a,b){return b.count-a.count});
  var html = [];
  for (var i = 0; i < 100; i++) {
    var stats = sortedWordList[i];
    html.push("<a href='#!/filter/"+stats.word+"'>"+stats.word+"</a>");
  }
  $('.tags').html(html.join(' '));

  $('.tags').on('click', 'a', function(){
    var word = $(this).attr('href').replace('#!/filter/', '');
    $('.pod').hide();
    var stats = wordStats[word];
    $(wordStats[word].elements).show();
  });
});
