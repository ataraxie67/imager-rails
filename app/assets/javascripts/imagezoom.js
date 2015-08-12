$(document)
  .on('page:change', function () {
    var rotcounter = 0;
    var rot = 0;
    var origin='none';
    var mouseX, mouseY;
    var panX=0;
    var panY=0;
    var scale=1;
   
    var panXprev=0;
    var panYprev=0;
    var image_mouse_down = false;
    
    var width=0;
    var height = 0;
    var timeout;

    function rotate(elm) {
      height =- $(elm).height();
        width =$(elm).width();
      panYprev=height;
      scale=1;
      // Apply the new offsets to the margin of the element.
      if (rotcounter == 0) {
        
        rot = 0;
        height=0;
        origin = '50% 50%';
        panXprev=0;
        panYprev=0;
        rotateprocess(elm);
        
      } else if (rotcounter == 90 || rotcounter == -270) {
        
        rot = 90;
        origin = 'left bottom';
        rotateprocess(elm);
      } else if (rotcounter == 180 || rotcounter == -180) {
        
        rot = 180;
        origin = '50% 100%';
        rotateprocess(elm);
      } else if (rotcounter == 270 || rotcounter == -90) {
        rot = -90;
        
        origin = 'right bottom';
        rotateprocess(elm);
      }
    }

    function rotateprocess(elm) {
      // Apply the new offsets to the margin of the element.
      $(elm)
        .css({
          '-webkit-transform': 'translateY('+height+'px) rotate('+rot+'deg) scale('+scale+')'
          , /* Safari */
          '-moz-transform': 'translateY('+height+'px) rotate('+rot+'deg) scale('+scale+')'
          , /* Firefox 3.6 Firefox 4 */
          /*-moz-transform-origin: right top; */
          '-ms-transform': 'translateY('+height+'px) rotate('+rot+'deg) scale('+scale+')'
          , /* IE9 */
          '-o-transform': 'translateY('+height+'px) rotate('+rot+'deg) scale('+scale+')'
          , /* Opera */
          'transform': 'translateY('+height+'px) rotate('+rot+'deg) scale('+scale+')'
          , /* W3C */
          '-webkit-transform-origin': origin
          , '-moz-transform-origin': origin
          , '-ms-transform-origin': origin
          , '-o-transform-origin': origin
          , 'transform-origin': origin
        });
    }


    
    $('.zoomin')
      .on('mousedown', function () {
        zoom_mouse_down=true;
        timeout = setInterval(function () {
          if (scale>2){return false;}
          else {scale=scale+0.01;}
          

          zoom (('.image_left img'),scale);
          scale=scale;
        //do same thing here again
         }, 1);

    return false;
        
      });

      $('.zoomin').mouseup(function () {
    clearInterval(timeout);
    return false;
      });
      $('.zoomin').mouseout(function () {
          clearInterval(timeout);
          return false;
      });
      $('.zoomout')
      .on('mousedown', function () {
        
        timeout = setInterval(function () {
          if (scale<0.5){return false;}
          else {scale=scale-0.01;}
          zoom (('.image_left img'),scale);
          scale=scale;
          
        //do same thing here again
         }, 1);

    return false;
        
      });

      $('.zoomout').mouseup(function () {
    clearInterval(timeout);
    return false;
      });
      $('.zoomout').mouseout(function () {
          clearInterval(timeout);
          return false;
      });
   
      function zoom (elm,height){
       $(elm).css({
             '-webkit-transition': 'height 0.3s ease-out',
            '-moz-transition': 'height 0.3s ease-out',
            '-o-transition':' height 0.3s ease-out',
            'transition':' height 0.3s ease-out',
            
        });
        

        $(elm).css({ 
            '-webkit-transform': 'translateY(' + panYprev + 'px) translateX(' + panXprev + 'px) rotate('+rot+'deg) scale('+scale+')'
          , '-moz-transform': 'translateY(' + panYprev + 'px) translateX(' + panXprev + 'px) rotate('+rot+'deg) scale('+scale+')'
          , '-ms-transform': 'translateY(' + panYprev + 'px) translateX(' + panXprev + 'px) rotate('+rot+'deg) scale('+scale+')'
          , '-o-transform': 'translateY(' + panYprev + 'px) translateX(' + panXprev + 'px) rotate('+rot+'deg) scale('+scale+')'
          , 'transform': 'translateY(' + panYprev + 'px)  translateX(' + panXprev + 'px) rotate('+rot+'deg) scale('+scale+')'
        });
      }
    $('.reset')
      .on('click', function () {
        panX=0;
        panY=0;
        panXprev=0;
        panYprev=0;
        scale=1;
        $('.image_left img')
          .css({
            "max-height": "100%"
            , "max-width": "100%"
            , "height": "auto"
            , "width": "auto"
          });
        rotate('.image_left img');
      });
    $('.rotateright')
      .on('click', function () {
        rotcounter += 90;
        if (rotcounter == 360) {
          rotcounter = 0;
        }
        rotate('.image_left img');
      });
    $('.rotateleft')
      .on('click', function () {
        rotcounter -= 90;
        if (rotcounter == -360) {
          rotcounter = 0;
        }
        rotate('.image_left img');
      });
    $('.image_left img')
      .mousedown(function (e) {
        image_mouse_down = true;
        console.log(image_mouse_down);
        mouseX = e.pageX;
        mouseY = e.pageY;
        return false;
      });
    $(window)
      .mouseup(function (e) {
        if (image_mouse_down){
           panXprev=panX;
           panYprev=panY;
        }
        image_mouse_down = false;
        mouseX = 0;
        mouseY = 0;
        
        return false;
      });
    $(document)
      .mousemove(function (e) {
        if (image_mouse_down == true) {
          
          var panXnew = mouseX - e.pageX;
          var panYnew = mouseY - e.pageY;
          panX=(panXprev+panXnew);
          panY=(panYprev+panYnew);
          pan(('.image_left img'), panX, panY);
        }
        return false;
      });

    function pan(elm, panx, pany) {
      // Apply the new offsets to the margin of the element.
      $(elm)
        .css({
          
          '-webkit-transform': 'translateY(' + pany + 'px) translateX(' + panx + 'px) rotate('+rot+'deg) scale('+scale+')'
          , '-moz-transform': 'translateY(' + pany + 'px) translateX(' + panx + 'px) rotate('+rot+'deg) scale('+scale+')'
          , '-ms-transform': 'translateY(' + pany + 'px) translateX(' + panx + 'px) rotate('+rot+'deg) scale('+scale+')'
          , '-o-transform': 'translateY(' + pany + 'px) translateX(' + panx + 'px) rotate('+rot+'deg) scale('+scale+')'
          , 'transform': 'translateY(' + pany + 'px)  translateX(' + panx + 'px) rotate('+rot+'deg) scale('+scale+')'
          
        });
    }
  }); 