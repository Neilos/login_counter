/*jslint browser: true*/
/*global $, jQuery*/

(function () {
    "use strict";

    // add html message(s) to a dedicated area of the page
    function showMessage(message) {
        $("#messages").html(message);
    }

    //###############
    //signup functions
    //###############

    // add html messages to the footer of the signup form modal window
    // replacing any error message that may have already been shown
    function showSignupFailureMessages(message) {
        if ($('#signupErrors').length > 0) {
            $('#signupErrors').replaceWith(message);
        } else {
            $(message).appendTo('#signUpFooter');
        }
    }

    // prepares the form for reuse
    // by resetting the form fields to their default values
    // deleting any error messages that may have been shown
    function clearSignupForm() {
        $('#formSignup')[0].reset();
        if ($('#signupErrors').length > 0) {
            $('#signupErrors').remove();
        }
    }

    // extracts the signup form data
    // then submits it via an ajax call
    // then shows triggers functions to show mesages from the server 
    // in locations on the page dependent on the type of response from server
    function submitSignupFormData() {
        var signupSerializedData = $('#formSignup').serialize();
        $.ajax({
            url: "/signup",
            type: "post",
            data: signupSerializedData,
            success: function (message) {
                $('#mySignup').modal('hide');
                showMessage(message);
            },
            error: function (jqXHR) {
                showSignupFailureMessages(jqXHR.responseText);
            }
        });
    }


    //###############
    //login functions
    //###############

    // add html messages to the footer of the login form modal window
    // replacing any error message that may have already been shown
    function showLoginFailureMessages(message) {
        if ($('#loginErrors').length > 0) {
            $('#loginErrors').replaceWith(message);
        } else {
            $(message).appendTo('#loginFooter');
        }
    }

    // prepares the form for reuse
    // by resetting the form fields to their default values
    // deleting any error messages that may have been shown
    function clearLoginForm() {
        $('#formLogin')[0].reset();
        if ($('#loginErrors').length > 0) {
            $('#loginErrors').remove();
        }
    }

    // extracts the login form data
    // then submits it via an ajax call
    // then either shows error messages
    // or redirects to the logged_in page
    function submitLoginFormData() {
        var loginSerializedData = $('#formLogin').serialize();
        $.ajax({
            url: "/login",
            type: "post",
            data: loginSerializedData,
            success: function () {
                $('#myLogin').modal('hide');
                window.location.href = "/logged_in";
            },
            error: function (jqXHR) {
                showLoginFailureMessages(jqXHR.responseText);
            }
        });
    }


    //################
    // event handlers
    //################

    // when page is loaded
    $(document).ready(function () {

        // add a click handled to the signup form
        $('#signup_form_div').on('submit', function (event) {
            event.preventDefault();
            submitSignupFormData();
        });

        // add an event handler to the 'hidden' event 
        // of the signup modal
        $('#mySignup').on('hidden', function () {
            clearSignupForm();
        });


          // add a click handled to the login form
        $('#login_form_div').on('submit', function (event) {
            event.preventDefault();
            submitLoginFormData();
        });

        // add an event handler to the 'hidden' event 
        // of the login modal
        $('#myLogin').on('hidden', function () {
            clearLoginForm();
        });

    });

}());