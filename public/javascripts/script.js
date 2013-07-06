function show_success_message( message ){
  $( "#messages" ).html( message )
}

function show_signup_failure_message( message ){
  $( "#signUpFooter" ).html( message )
}

$(document).ready(function() {
  $( '#signup_form' ).on('submit', function( event ){
    event.preventDefault();
    var serialized_data = $( "input" ).serialize();
    $.ajax({
      url: "/signup",
      type: "post",
      data: serialized_data,
      success: function(message){ 
        $('#mySignup').modal('hide');
        show_success_message(message);
      },
      error: function(jqXHR, textStatus, error){ 
        show_signup_failure_message(jqXHR.responseText) }
    })
  });
});