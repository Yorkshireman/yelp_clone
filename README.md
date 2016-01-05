[![Coverage Status](https://coveralls.io/repos/Yorkshireman/yelp_clone/badge.svg?branch=master&service=github)](https://coveralls.io/github/Yorkshireman/yelp_clone?branch=master)  
[![Build Status](https://travis-ci.org/Yorkshireman/yelp_clone.svg?branch=master)](https://travis-ci.org/Yorkshireman/yelp_clone)

A [Yelp](http://yelp.com) clone built on Rails. I am still adding the finishing touches to this app, but all of the main functionality is complete and fully tested (built using TDD).  

####Features:  

- User has choice of using a standard user sign-up/sign-in or Facebook authentication;
- Create Restaurants and upload an image for it;  
- Review Restaurants and leave Star ratings;
- Endorse Reviews.  

####Technologies:  
Ruby on Rails, Javascript, JQuery, RSpec & Capybara, Amazon S3, Paperclip.   

Deployed to Heroku [here](https://desolate-peak-3419.herokuapp.com/).

To run locally:

`git clone git@github.com:Yorkshireman/yelp_clone.git`  
`bundle`  
`rake db:create`  
`rake db:migrate`  
`rails s`  
(navigate to localhost:3000 in your browser).

`rspec` to run the tests.
