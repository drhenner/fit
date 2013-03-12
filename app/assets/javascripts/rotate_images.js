var Hadean = window.Hadean || {};

// If we already have the Appointments namespace don't override
if (typeof Hadean.Welcome == "undefined") {
    Hadean.Welcome = {};
}

// If we already have the Appointments object don't override
if (typeof Hadean.Welcome.rotateImages == "undefined") {

    Hadean.Welcome.rotateImages = {
        transitionSpeed    : 475,
        speed    : 5000,
        images   : [],
        currentIndex : 0,
        initialize      : function( ) {
          // If the user clicks add new variant button
          Hadean.Welcome.rotateImages.images = ['/assets/landing_page/landing_page_opt_rob1.jpg','/assets/landing_page/landing_page_opt_rob2.jpg','/assets/landing_page/landing_page_opt_rob4.jpg','/assets/landing_page/landing_page_opt2.jpg']
          Hadean.Welcome.rotateImages.next();
        },
        setNext : function(){
          setTimeout('Hadean.Welcome.rotateImages.next()', Hadean.Welcome.rotateImages.speed);
        },
        isMobile : function(){
          return ( /Android|webOS|iPhone|iPod|BlackBerry/i.test(navigator.userAgent) );
        },
        next : function(){
          if (Hadean.Welcome.rotateImages.isMobile()) {
            $('.anystretch img').hide();

            $('#signup_form_wrapper').css('background-color', '#888');
            $('#signup_form_wrapper').css('top', 0);
            $('#signup_form_wrapper').css('left', 0);
            $('#signup_form_wrapper').css('width', '370px');
            $('.nofity-button-wrapper').css('margin-top', '10px');
            $('#mobile-banner').show();
            $('key-to-changing').hide();
            $('#main-landing-signup-image').hide();
            $('#mobile-landing-signup-image').show();
            $('#input-fields').css('width', 353);
            $('#input-fields').css('float', 'none');
            $('#input-fields').css('min-height', '335px');
            $('#background-transparent').css('min-height', '335px');
            $('#background-non-transparent').css('min-height', '335px');
            $('#background-non-transparent').css('padding-left', 8);
            $.each($('#input-fields li'), function(index, obj){
              $(obj).removeClass();
            })
            $('#background-transparent').css('width', 353);
            $('#background-non-transparent').css('width', 353);
            $('#ufcfit-logo').css('float', 'none');

          } else {
            $('.anystretch').show();
            $.anystretch(Hadean.Welcome.rotateImages.images[Hadean.Welcome.rotateImages.currentIndex], {speed: Hadean.Welcome.rotateImages.transitionSpeed});
          }

          Hadean.Welcome.rotateImages.currentIndex = Hadean.Welcome.rotateImages.nextIndex();
          Hadean.Welcome.rotateImages.setNext();
        },
        prev : function(obj){
          $.anystretch(Hadean.Welcome.rotateImages.images[Hadean.Welcome.rotateImages.currentIndex], {speed: Hadean.Welcome.rotateImages.transitionSpeed});
          Hadean.Welcome.rotateImages.currentIndex = Hadean.Welcome.rotateImages.prevIndex();
        },
        nextIndex : function() {
          if ((Hadean.Welcome.rotateImages.currentIndex + 1) >= Hadean.Welcome.rotateImages.numberOfImages()) {
            return 0;
          } else {
            return (Hadean.Welcome.rotateImages.currentIndex + 1);
          }
        },
        prevIndex : function() {
          if ((Hadean.Welcome.rotateImages.currentIndex - 1) <= 0) {
            return 0;
          } else {
            return (Hadean.Welcome.rotateImages.currentIndex - 1);
          }
        },
        numberOfImages : function(){
          return Hadean.Welcome.rotateImages.images.length;
        }
    };

    jQuery(function() {
      Hadean.Welcome.rotateImages.initialize();
    });
};
