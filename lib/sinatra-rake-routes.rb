require 'rake'
require 'sinatra-rake-routes/version'

class SinatraRakeRoutes
  @@app_class = nil

  # Sinatra compiles routes into regexes. See below link for how this works:
  # https://github.com/sinatra/sinatra/blob/4c7d38eb1b2cc02ce51029f28e0c3c34ca12ccfd/lib/sinatra/base.rb#L1618
  # The below regexes cover some of the common cases.
  HYPHEN_REGEX = /(?:\-|%2[Dd])/
  NAMED_PARAM_REGEX = /([^\/?#]+)/
  PERIOD_REGEX = /(?:\.|%2[Ee])/
  SPLAT_REGEX = /(.*?)/

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
        source.gsub!(PERIOD_REGEX.source, ".")
        source.gsub!(SPLAT_REGEX.source, "*")
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
