require 'rake'
require 'sinatra-rake-routes/version'

class SinatraRakeRoutes
  @@app_class = nil

  def self.set_app_class(klass)
    if klass.try(:routes).is_a?(Hash)
      @@app_class = klass
    else
      raise "#{klass} does not appear to be a valid Sinatra Application"
    end
  end

  def self.app_class
    @@app_class
  end
end
