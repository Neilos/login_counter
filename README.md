This repository contains my coding output in response to a coding challenge set in June 2013 by Evgeny Shadchnev at Makers Academy in London.

The Task
========
Let's create an app that allows the user to keep the count of how many times they logged into the app. Not terribly useful but good for practice.

It will have the following functionality:

  * The homepage will explain what the app does and have login and sign up forms
  * The sign up form will be submitted via ajax using JQuery
  * If the sign up is successful, it'll show the corresponding message (as part of the page)
  * If the sign up is not successful (empty username or password, duplicate username), it will show a message as well.
  * The user should be able to log in after it has signed up. A successful login will redirect to another page that will show the count of how many times the user has logged in
  * An unsuccessul login will show an error message without reloading the page
  * This page will have a log out button or link. If the user clicks it a message will sho saying goodbye
  * It a user is already logged in, the home page should automatically redirect to the logged in page

Implementation
--------------
  * Please have acceptance tests for the app. Write them first.
  * Use bcrypt, hasing and salting to manage the password of the user
  * Use either postgres or mongoid as the database. Use either mongoid or datamapper.
  * Use a cookie with a customer secret key
  * Set your cookie to be http-only
  * Deploy to heroku. Make sure it works there (you'll need to add necessary add ons).
  * Validate your HTML with http://validator.w3.org/. Try to fix the errors it may show
  * Validate your CSS with http://jigsaw.w3.org/css-validator/. Try to fix the errors it may show.
  * Validate your JS with http://www.jslint.com/. Try to fix the errors it may show
  * Finally, make your app good. It's just a couple of pages with the most basic functionality. Make an attempt at web design but don't overcomplicate it.
