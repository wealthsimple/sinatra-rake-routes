# sinatra-rake-routes
`rake routes` command for Sinatra applications

## Usage

Add the below code to your Rakefile. Make sure to  require `sinatra-rake-routes/tasks` *after* the `:configure_routes` task is defined, otherwise it won't be picked up correctly.

```ruby
# Rakefile
task :configure_routes do
  require "sinatra-rake-routes"
  require './my_app'
  SinatraRakeRoutes.set_app_class(MyApp)
end

require "sinatra-rake-routes/tasks"
```
