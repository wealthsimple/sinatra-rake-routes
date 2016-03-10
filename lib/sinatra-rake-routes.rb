require 'rake'
require 'sinatra-rake-routes/version'

class SinatraRakeRoutes
  @@app_class = nil

  def self.set_app_class(klass)
    if klass.respond_to?(:routes) && klass.routes.is_a?(Hash)
      @@app_class = klass
    else
      raise "#{klass} does not appear to be a valid Sinatra Application"
    end
  end

  def self.app_class
    @@app_class
  end

  def self.output
    str = []
    app_routes = app_class.routes
    app_routes.each_with_index do |(http_method, routes_list), i|
      str << http_method
      routes = []
      routes_list.each do |item|
        source = item[0].source
        item[1].each do |s|
          source.sub!(/\(.+?\)/, ':'+s)
        end
        routes << source[1...-1]
      end
      str << routes.sort.join("\n") + "\n"
    end
    str.join("\n")
  end
end
