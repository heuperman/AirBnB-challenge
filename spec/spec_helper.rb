ENV['RACK_ENV'] = 'test'

require 'capybara'
require 'capybara/rspec'
require 'rake'
require 'rspec'
require 'simplecov'
require 'simplecov-console'
require_relative '../app'

Rake.application.load_rakefile

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:each) do
    Rake::Task['test_database_setup'].execute
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

Capybara.app = BnB
