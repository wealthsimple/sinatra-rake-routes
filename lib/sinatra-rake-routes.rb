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

  def to_s
    str = []
    self.class.app_class.routes.each do |http_method, routes|
      str << http_method
      routes = routes.map { |route| decompile(*route) }
      str << routes.sort.join("\n") + "\n"
    end
    str.join("\n")
  end

  private

  # Below method taken from Sinatra::Contrib
  # https://github.com/sinatra/sinatra-contrib/blob/66892d3789ba23f157b17d67570479e97d7eaa95/lib/sinatra/decompile.rb#L70
  def decompile(pattern, keys = nil, *)
    # Everything in here is basically just the reverse of
    # Sinatra::Base#compile
    #
    # Sinatra 2.0 will come with a mechanism for this, making this obsolete.
    pattern, keys = pattern if pattern.respond_to? :to_ary
    str     = pattern.inspect
    return pattern unless str.start_with? '/' and str.end_with? '/'
    str.gsub! /(?:\\-|%2[Dd])/, "-"
    str.gsub! /^\/(\^|\\A)?|(\$|\\z)?\/$/, ''
    str.gsub! encoded(' '), ' '
    return pattern if str =~ /^[\.\+]/
    str.gsub! '((?:[^\.\/?#%]|(?:%[^2].|%[2][^Ee]))+)', '([^\/?#]+)'
    str.gsub! '((?:[^\/?#%]|(?:%[^2].|%[2][^Ee]))+)', '([^\/?#]+)'
    str.gsub! /\([^\(\)]*\)|\([^\(\)]*\([^\(\)]*\)[^\(\)]*\)/ do |part|
      case part
      when '(.*?)'
        return pattern if keys.shift != 'splat'
        '*'
      when /^\(\?\:(\\*.)\|%[\w\[\]]+\)$/
        $1
      when /^\(\?\:(%\d+)\|([^\)]+|\([^\)]+\))\)$/
        URI.unescape($1)
      when '([^\/?#]+)'
        return pattern if keys.empty?
        ":" << keys.shift
      when /^\(\?\:\\?(.)\|/
        char = $1
        return pattern unless encoded(char) == part
        Regexp.escape(char)
      else
        return pattern
      end
    end
    str.gsub /(.)([\.\+\(\)\/])/ do
      return pattern if $1 != "\\"
      $2
    end
  end

  def encoded(char)
    @uri_parser ||= URI::Parser.new
    enc = @uri_parser.escape(char)
    escaped = [Regexp.escape(enc), @uri_parser.escape(char, /./)]
    enc = "(?:#{escaped.join('|')})" if enc == char
    enc = "(?:#{enc}|#{encoded('+')})" if char == " "
    enc
  end

end
