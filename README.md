A [Yelp](http://yelp.com) clone built on Rails.

TDD; RSpec, Capybara.

Javascript/JQuery.

CSS is Bootstrap with some tweaks.

- User has choice of using a standard user sign-up/sign-in or Facebook authentication;
- Create Restaurants and upload an image for it (Amazon S3 and Paperclip);
- Review Restaurants and leave Star ratings;
- Endorse Reviews.

Deployed to Heroku [here](https://desolate-peak-3419.herokuapp.com/).

To run locally:

`git clone git@github.com:Yorkshireman/yelp_clone.git`  
`bundle`  
`rake db:create`  
`rake db:migrate`  
`rails s`  
(navigate to localhost:3000 in your browser).

`rspec` to run the tests.
