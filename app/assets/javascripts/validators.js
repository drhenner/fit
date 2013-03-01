var UfcFit = window.UfcFit || { };

UfcFit.Validators = {
  CreditCards : {
    currentCardType : null,
    creditCardInput : null,
    valid : false,
    cardRegexps     : [
                           [ 'Visa Electron'      , /^(417500|(4917|4913|4508|4844)\d{2})\d{10}$/ ]
                         , [ 'Visa'               , /^4\d{12}(\d{3})?$/                           ]
                         , [ 'MasterCard'         , /^(5[1-5]\d{4}|677189)\d{10}$/                ]
                         , [ 'discover'           , /^(6011|65\d{2})\d{12}$/                      ]
                         , [ 'American Express'   , /^(34|37)\d{13}$/                             ]
                        , [ 'Diners Club'        , /^3(0[0-5]|[68]\d)\d{11}$/                    ]
                      //  , [ 'JCB'                , /^35(2[89]|[3-8]\d)\d{12}$/                ]
                      //   , [ 'Solo'               , /^(6767|6334)\d{12}(\d{2,3})?$/               ]
                      // , [ 'dankort'            , /^5019\d{12}$/                                ]
                      //   , [ 'Maestro'            , /^((5018|5020|5038|6304|6759|6761|4903|4905|4911|4936|6333|6759)\d{2}|564182|633100)\d{10,13}$/ ]
                      // , [ 'forbrugsforeningen' , /^600722\d{10}$/                              ]
                      //   , [ 'Laser'              , /^(6304|6706|6771|6709)\d{12,15}$/            ]
                      ],
    initialize      : function() {
      UfcFit.Validators.CreditCards.creditCardInput = $('#number');
      var cardInput = jQuery(UfcFit.Validators.CreditCards.creditCardInput);
      cardInput.
              bind('blur', function() {
                  UfcFit.Validators.CreditCards.validateNumber(UfcFit.Validators.CreditCards.creditCardInput);
                }
              );
    },
    validateNumber : function(creditCardInputObject) {
      number = creditCardInputObject.val();
      //does it pass the luhn calculation
      validLuhnValue = UfcFit.Validators.CreditCards.validLuhn(number);
      //does it pass the CC regEX
      validRegExValue = UfcFit.Validators.CreditCards.validRegEx(number);
      if (validLuhnValue && validRegExValue) {
        //GOOD now remove any error messages
        UfcFit.Validators.CreditCards.valid = true;
        creditCardInputObject.parent("div").removeClass('errors')
      } else {
        // Give the user an error message
        UfcFit.Validators.CreditCards.valid = false;
        creditCardInputObject.parent("div").addClass('errors')
      }
    },
    validLuhn : function(number) {
      if (number.length > 19)
          return (false);

      sum = 0; mul = 1; l = number.length;
      for (i = 0; i < l; i++)
      {
          digit = number.substring(l-i-1,l-i);
          tproduct = parseInt(digit ,10)*mul;
          if (tproduct >= 10){
            sum += (tproduct % 10) + 1;
          } else {
            sum += tproduct;
          }

          if (mul == 1){
            mul++;
          } else {
            mul--;
          }
      }
      if ((sum % 10) == 0) {
       return (true);
      } else {
       return (false);
      }
    },
    validRegEx : function(number) {
        thisCardType = UfcFit.Validators.CreditCards.cardType(number);
        if (thisCardType == null) {
          return (false);
        }else{
          return (true);
        }
        return thisCardType;
    },
    cardType : function(number) {
      var name = null;
      jQuery.each(UfcFit.Validators.CreditCards.cardRegexps, function (i,e) {
        if (number.match(e[1])) {
          name = e[0];
          return false;
        }
      });
      return name;
    }
  }
}
UfcFit.Validators.CreditCards.initialize();
