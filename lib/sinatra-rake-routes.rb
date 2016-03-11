require 'rake'
require 'sinatra-rake-routes/version'

class SinatraRakeRoutes
  @@app_class = nil

  # Sinatra replaces hyphens with the following regex:
  HYPHEN_REGEX = /(?:\-|%2[Dd])/
  # Sinatra replaces named params with the following regex:
  NAMED_PARAM_REGEX = /([^\/?#]+)/

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
        source.gsub!(HYPHEN_REGEX.source, "-")
        item[1].each do |s|
          source.sub!(NAMED_PARAM_REGEX.source, ":#{s}")
        end
        routes << source[1...-1]
      end
      str << routes.sort.join("\n") + "\n"
    end
    str.join("\n")
  end
end
