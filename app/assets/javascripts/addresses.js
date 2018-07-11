// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function () {
  $("#new_address_verification").validate({
    rules: {
      "address_verification[street_address]": "required",
      "address_verification[city]": "required",
      "address_verification[zip_code]": {
        required: true,
        digits: true,
        minlength: 5,
        maxlength: 5
      }
    },
    messages: {
      "address_verification[street_address]": "Please provide a valid street address",
      "address_verification[city]": "Please provide a valid city",
      "address_verification[zip_code]": {
        required: "Please provide a valid zip code",
        digits: "Zip code can only contain digits",
        minlength: "Zip code must be 5 digits long",
        maxlength: "Zip code must be 5 digits long"
      }
    },
    submitHandler: function (form) {
      forms.submit();
    }
  });
});