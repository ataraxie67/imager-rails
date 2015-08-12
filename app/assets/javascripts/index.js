$(document).on('page:change',function(){
  /*
   if ($('.next').length) {
    
    $('body').scroll(function() {
      console.log("foo");
      var url = $("a[rel='next']").attr('href');
      	
      if (url && $('body').scrollTop() > $('body').prop('scrollHeight')-$('body').height()-200) {
        $('.pagination').text("Please Wait...");
        return $.getScript(url);
      }
    });
    return $('body').scroll();
  }
 $('input[type=submit]').on('click',function(){
      console.log("foo");
  });
*/var $w = $(window);
  function visible(elm,partial,hidden,direction){

        if ($(elm).length < 1)
            return;

        var $t        = $(elm).length > 1 ? $(elm).eq(0) : $(elm),
            t         = $t.get(0),
            vpWidth   = $w.width(),
            vpHeight  = $w.height(),
            direction = (direction) ? direction : 'both',
            clientSize = hidden === true ? t.offsetWidth * t.offsetHeight : true;

        if (typeof t.getBoundingClientRect === 'function'){

            // Use this native browser method, if available.
            var rec = t.getBoundingClientRect(),
                tViz = rec.top    >= 0 && rec.top    <  vpHeight,
                bViz = rec.bottom >  0 && rec.bottom <= vpHeight,
                lViz = rec.left   >= 0 && rec.left   <  vpWidth,
                rViz = rec.right  >  0 && rec.right  <= vpWidth,
                vVisible   = partial ? tViz || bViz : tViz && bViz,
                hVisible   = partial ? lViz || rViz : lViz && rViz;

            if(direction === 'both')
                return clientSize && vVisible && hVisible;
            else if(direction === 'vertical')
                return clientSize && vVisible;
            else if(direction === 'horizontal')
                return clientSize && hVisible;
        } else {

            var viewTop         = $w.scrollTop(),
                viewBottom      = viewTop + vpHeight,
                viewLeft        = $w.scrollLeft(),
                viewRight       = viewLeft + vpWidth,
                offset          = $t.offset(),
                _top            = offset.top,
                _bottom         = _top + $t.height(),
                _left           = offset.left,
                _right          = _left + $t.width(),
                compareTop      = partial === true ? _bottom : _top,
                compareBottom   = partial === true ? _top : _bottom,
                compareLeft     = partial === true ? _right : _left,
                compareRight    = partial === true ? _left : _right;

            if(direction === 'both')
                return !!clientSize && ((compareBottom <= viewBottom) && (compareTop >= viewTop)) && ((compareRight <= viewRight) && (compareLeft >= viewLeft));
            else if(direction === 'vertical')
                return !!clientSize && ((compareBottom <= viewBottom) && (compareTop >= viewTop));
            else if(direction === 'horizontal')
                return !!clientSize && ((compareRight <= viewRight) && (compareLeft >= viewLeft));
        }
    };



    
    $('#next-page').show();
    $(document).on("scroll",function(){
        if(visible('#next-page') && $('.first').length){
         
          var url = $("a[rel='next']").attr('href');
          console.log(url);
          if(!url){$('button#next-page').html("no more pages");}
          else {
            $('.pagination').text("Please Wait...");
            return $.getScript(url);
          };
       
       
      }
    })
    
    $('#next-page').click(function(){
      var url = $("a[rel='next']").attr('href');
      console.log(url);
      if(!url){$('button#next-page').html("no more pages");}
      else {
        $('.pagination').text("Please Wait...");
        return $.getScript(url);
      };
     
    })
 
});
