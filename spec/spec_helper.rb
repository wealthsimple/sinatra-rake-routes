require 'rspec'

Dir["./spec/support/**/*.rb"].each { |f| require f }

require './lib/sinatra-rake-routes'

RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
end
