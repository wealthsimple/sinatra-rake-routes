# sinatra-rake-routes
`rake routes` command for Sinatra applications

## Usage

```ruby
# Rakefile
task :configure_routes do
  require "sinatra-rake-routes"
  require './my_app'
  SinatraRakeRoutes.set_app_class(MyApp)
end

require "sinatra-rake-routes/tasks"
```
