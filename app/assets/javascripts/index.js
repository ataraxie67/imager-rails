$(document).on('page:change',function(){
  
   if ($('.next').length) {
    
    $('.fixed_left_pane').scroll(function() {
      
      var url = $("a[rel='next']").attr('href');
      	
      if (url && $('.fixed_left_pane').scrollTop() > $('.fixed_left_pane').prop('scrollHeight')-$('.fixed_left_pane').height()-200) {
        $('.pagination').text("Please Wait...");
        return $.getScript(url);
      }
    });
    return $('.fixed_left_pane').scroll();
  }
  
});
