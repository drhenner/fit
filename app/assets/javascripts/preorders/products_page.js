// media-purchase
var UfcFit = window.UfcFit || { };

if (typeof UfcFit.ProductPage == "undefined") {
    UfcFit.ProductPage = {};
}
var ddd = null;
if (typeof UfcFit.ProductPage.mediaPurchase == "undefined") {

    UfcFit.ProductPage.mediaPurchase = {
        currentIndex : 0,
        initialize      : function( ) {
          // If the user clicks add new variant button
          // UfcFit.ProductPage.mediaPurchase

          $('div.media-purchase ul').on('mouseup', 'li', function(event) {
            UfcFit.ProductPage.mediaPurchase.changeSelection(this);
            //alert($(this).text());
          });
        },
        changeSelection : function(thisObj) {
          ddd = $('select.media-purchase');
          //alert(ddd.val());
          needToFind = true;
          jQuery.each($("select.media-purchase option"), function(index, obj) {
            if ($(obj).text() == $(thisObj).text() && needToFind) {
              needToFind = false;
              alert($(obj).val());
            }
          })
        }

    };
    jQuery(function() {
      UfcFit.ProductPage.mediaPurchase.initialize();
    });
}
