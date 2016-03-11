require 'rake'
require 'sinatra-rake-routes/version'

class SinatraRakeRoutes
  @@app_class = nil

  # Sinatra compiles routes into regexes. See below link for how this works:
  # https://github.com/sinatra/sinatra/blob/4c7d38eb1b2cc02ce51029f28e0c3c34ca12ccfd/lib/sinatra/base.rb#L1618
  # The below regexes cover some of the common cases.
  HYPHEN_REGEX = /(?:\-|%2[Dd])/
  NAMED_PARAM_REGEX_SOURCE = "([^\/?#]+)"
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

  def to_s
    str = []
    self.class.app_class.routes.each do |http_method, routes|
      str << http_method
      routes = routes.map { |route| decompile_route(route) }
      str << routes.sort.join("\n") + "\n"
    end
    str.join("\n")
  end

private

  def decompile_route(route)
    source = route[0].source
    params = route[1]
    source.gsub!(HYPHEN_REGEX.source, "-")
    source.gsub!(PERIOD_REGEX.source, ".")
    source.gsub!(SPLAT_REGEX.source, "*")
    params.each do |param|
      source.sub!(NAMED_PARAM_REGEX_SOURCE, ":#{param}")
    end
    # Remove leading "\A" and trailing "\z"
    source[2...-2]
  end
end
