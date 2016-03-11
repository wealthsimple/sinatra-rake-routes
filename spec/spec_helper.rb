require 'rspec'
require 'rspec/collection_matchers'
require 'rspec/its'

Dir["./spec/support/**/*.rb"].each { |f| require f }

require './lib/sinatra-rake-routes'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
end
