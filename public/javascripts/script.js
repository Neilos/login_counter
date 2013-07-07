
// add html message(s) to a dedicated area of the page
function showMessage( message ){
  $( "#messages" ).html( message );
}

// add html messages to the footer of the signup form modal window
// replacing any error message that may have already been shown
function showSignupFailureMessages( message ){
  if ($('#signupErrors').length > 0){
    $('#signupErrors').replaceWith( message );
  }else{
    $( message ).appendTo('#signUpFooter');
  }
}

// prepares the form for reuse
// by resetting the form fields to their default values
// deleting any error messages that may have been shown
function clearSignupForm(){
  $('#formSignup')[0].reset();
  if ($('#signupErrors').length > 0){
    $('#signupErrors').remove();
  }
}

// extracts the signup form data
// then submits it via an ajax call
// then shows triggers functions to show mesages from the server 
// in locations on the page dependent on the type of response from server
function submitSignupFormData(){
  var serialized_data = $( "input" ).serialize();
  $.ajax({
    url: "/signup",
    type: "post",
    data: serialized_data,
    success: function(message){ 
      $('#mySignup').modal('hide')
      showMessage(message)
    },
    error: function(jqXHR, textStatus, error){ 
      showSignupFailureMessages(jqXHR.responseText) 
    }
  });
}

// when page is loaded
$(document).ready(function() {

  // add a click handled to the signup form
  $( '#signup_form_div' ).on('submit', function( event ){
    event.preventDefault();
    submitSignupFormData();
  });

  // add an event handler to the 'hidden' event 
  // of the signup modal
  $('#mySignup').on('hidden', function () {
    clearSignupForm();
  });
  
});