# sinatra-rake-routes [![Circle CI](https://circleci.com/gh/wealthsimple/sinatra-rake-routes.svg?style=svg)](https://circleci.com/gh/wealthsimple/sinatra-rake-routes)

`rake routes` command for Sinatra applications

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
A/users/:user_id/messages\
A/users\

GET
A/users/:user_id/messages/:message_id\
A/users/:user_id/messages\
A/users/:user_id\

HEAD
A/users/:user_id/messages/:message_id\
A/users/:user_id/messages\
A/users/:user_id\

PUT
A/users/:user_id/messages/:message_id\
A/users/:user_id\

DELETE
A/users/:user_id\
```
