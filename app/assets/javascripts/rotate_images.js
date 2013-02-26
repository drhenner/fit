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
        next : function(){
          if ($('body').width() >= 500) {
            $('.anystretch').show();
            $.anystretch(Hadean.Welcome.rotateImages.images[Hadean.Welcome.rotateImages.currentIndex], {speed: Hadean.Welcome.rotateImages.transitionSpeed});
          } else {
            $('.anystretch img').hide();
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
