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
          jQuery('#submit-notify').live('click', function() {
            Hadean.Welcome.tempSignup.submitForm();
          });
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
