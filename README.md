hackerstreet.in
===============

New HSI Prototype 


  1.  Sign up for a Swiftype account, then create an API based engine with a Document Type called "post".
  2. Create a .env file with your Swiftype API key, engine key, engine slug, and default host (see .env.example). 
  Note: The first two steps are only needed to perform search using swiftype(other features should work without doing this)
  3.  Clone this repository and run bundle install, rake db:create, and rake db:migrate.
  4.  Create database.yml in config folder (you can use the content in database.yml.example file without any problem)
  5.  Run the demo with foreman start.

