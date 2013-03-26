var Hadean = window.Hadean || {};

// If we already have the Appointments namespace don't override
if (typeof Hadean.Welcome == "undefined") {
    Hadean.Welcome = {};
}
debug_var = null;
// If we already have the Appointments object don't override
if (typeof Hadean.Welcome.tempSignup == "undefined") {

    Hadean.Welcome.tempSignup = {

        initialize      : function( ) {
          // If the user clicks add new variant button
          jQuery('#new_user').submit(function(event) {
            Hadean.Welcome.tempSignup.submitForm();

            // prevent the form from submitting with the default action
            return false;
          });
          jQuery(document).on('click', ' #submit-notify', function() {
            Hadean.Welcome.tempSignup.submitForm();
          });
          if (Hadean.Welcome.tempSignup.isMobile()) {
            Hadean.Welcome.tempSignup.setMobileCss();
          }
        },
        isMobile : function(){
          return ( /Android|webOS|iPhone|iPod|BlackBerry/i.test(navigator.userAgent) );
        },
        setMobileCss : function() {
          $('.anystretch img').hide();
          $('#body_wrapper').css('background', '#888');
          $('#signup_form_wrapper').css('background-color', '#888');
          $('#signup_form_wrapper').css('top', 0);
          $('#signup_form_wrapper').css('left', 0);
          $('#signup_form_wrapper').css('width', '320px');
          $('#signup_form_wrapper').css('margin', '0px auto');
          $('.nofity-button-wrapper').css('margin-top', '10px');
          $('#mobile-banner').show();
          $('#mobile-banner').css('text-align', 'center');
          $('#mobile-banner').css('background-color', '#000');
          $('#key-to-changing').css('display', 'none');
          $('#main-landing-signup-image').hide();
          $('#mobile-landing-signup-image').show();
          $('#mobile-landing-signup-image').css('width', '320px');
          $('#ufcfit-logo').css('width', '320px');
          $('#input-fields').css('width', '320px');
          $('#input-fields').css('float', 'none');
          $('#input-fields').css('padding', '0');
          $('#input-fields').css('min-height', '320px');
          $('#background-transparent').css('min-height', '320px');
          $('#background-transparent').css('background-color', '#000');
          $('#background-non-transparent').css('min-height', '320px');
          $('#background-non-transparent').css('padding-left', 8);
          $.each($('#input-fields li'), function(index, obj){
            $(obj).removeClass();
            $(obj).css('padding-right', '8px');
            $(obj).css('width', '100%');
          })
          //$('#background-transparent').css('width', 353);
          //$('#background-non-transparent').css('width', 353);
          $('#ufcfit-logo').css('float', 'none');
        },
        submitForm : function(){
          jQuery.ajax({
            type : "POST",
            url: "/users",
            data: jQuery('#new_user').serialize(),
            success: function(jsonText){
              debug_var = jsonText;
              if (typeof( debug_var.errors) == "undefined") {
                jQuery('#new_user').hide();
                jQuery('#please-subscribe').hide();
                jQuery('#background-non-transparent h2').hide();
                jQuery('#congrats_user').fadeIn();
              }else{
                jQuery('#user_email').removeClass('error');
                jQuery('#user_country_id').removeClass('error');
                $.each(jQuery.parseJSON( debug_var.errors ), function(index, value) {
                  if (value != null) {
                    jQuery('#user_' + index).addClass('error');
                    if (index == 'email') {
                      alert("Email: " + value)
                    }
                  }
                })
              }
            },
            dataType: 'json'
          });
        }
    };

    jQuery(function() {
      Hadean.Welcome.tempSignup.initialize();
    });
};
