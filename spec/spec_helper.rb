require 'rspec'
require 'rspec/collection_matchers'
require 'rspec/its'

Dir["./spec/support/**/*.rb"].each { |f| require f }

require './lib/sinatra-rake-routes'

RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
