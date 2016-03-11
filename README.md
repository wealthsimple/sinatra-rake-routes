# sinatra-rake-routes [![Circle CI](https://circleci.com/gh/wealthsimple/sinatra-rake-routes.svg?style=svg)](https://circleci.com/gh/wealthsimple/sinatra-rake-routes) ![](https://img.shields.io/gem/v/sinatra-rake-routes.svg)

`rake routes` command for Sinatra applications for printing out all defined routes.

## Usage

Install by adding the following to your Gemfile:

```ruby
gem 'sinatra-rake-routes'
```

Add the below code to your Rakefile. Make sure to  require `sinatra-rake-routes/tasks` *after* the `:configure_routes` task is defined, otherwise it won't be picked up correctly.

```ruby
# Rakefile

task :configure_routes do
  require "sinatra-rake-routes"
  # Tell SinatraRakeRoutes what your Sinatra::Base application class is called:
  require './my_app'
  SinatraRakeRoutes.set_app_class(MyApp)
end

require "sinatra-rake-routes/tasks"
```

## Example output

```
bundle exec rake routes

POST
/users
/users/:user_id/messages

GET
/users/:user_id
/users/:user_id/messages
/users/:user_id/messages/:message_id

HEAD
/users/:user_id
/users/:user_id/messages
/users/:user_id/messages/:message_id

PUT
/users/:user_id
/users/:user_id/messages/:message_id

DELETE
/users/:user_id
```
