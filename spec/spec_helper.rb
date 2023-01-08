ENV['RACK_ENV'] = 'test'
require "./environment.rb"
require "./app.rb"
require 'capybara/rspec'
require 'test/unit'

Capybara.app = Sinatra::Application.new

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.javascript_driver = :selenium

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include Rack::Test::Methods
  
  config.before(:example) do
    config.run_all_when_everything_filtered = true
    config.filter_run :focus
    config.order = 'random'
    
    qs = QueryService.new('test')
    qs.create_table('EXAM_DATA')
    qs.conn_close
  
  end
  
  config.after(:example) do
    qs = QueryService.new('test')
    qs.delete_database
    qs.conn_close
  end
 
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

 
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end
