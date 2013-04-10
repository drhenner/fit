// media-purchase
var UfcFit = window.UfcFit || { };

if (typeof UfcFit.ProductPage == "undefined") {
    UfcFit.ProductPage = {};
}
if (typeof UfcFit.ProductPage.mediaPurchase == "undefined") {

    UfcFit.ProductPage.mediaPurchase = {
        currentIndex : 0,
        initialize      : function( ) {
          // If the user clicks add new variant button
          // UfcFit.ProductPage.mediaPurchase
          if ($.browser.msie) {
            $("select.media-purchase").change(function() {
              UfcFit.ProductPage.mediaPurchase.changeSelection(this);
            });
          } else {
            $('div.media-purchase ul').on('mouseup', 'li', function(event) {
              UfcFit.ProductPage.mediaPurchase.changeSelection(this);
            });
          }

          $('.has-tip.tip-left .icon-minus-sign ').hover( function() {
            //UfcFit.ProductPage.mediaPurchase.removeNub();
            setTimeout("UfcFit.ProductPage.mediaPurchase.removeNub()", 10);
          });
          //setTimeout("UfcFit.ProductPage.mediaPurchase.removeNub()", 250);
        },
        changeSelection : function(thisObj) {
          needToFind = true;
          if ($.browser.msie) {
            alert('test 1');
          }
          jQuery.each($("select.media-purchase option"), function(index, obj) {
            if ($(obj).text() == $(thisObj).text() && needToFind) {
              needToFind = false;
              if ($.browser.msie) {
                alert($(obj).val());
              }
              $("select.media-purchase option").val($(obj).val());
              form = $(obj).parents('form');
              form.get(0).submit();
              // time to make a form submission with the new value

            }
          })
        },
        removeNub : function() {
          $.each($('.tooltip.tip-left > .nub'), function(i, obj) {
            $(obj).hide();
          });
        }

    };
    jQuery(function() {
      UfcFit.ProductPage.mediaPurchase.initialize();
    });
}
