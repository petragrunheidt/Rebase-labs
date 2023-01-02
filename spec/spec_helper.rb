ENV['RACK_ENV'] = 'test'
require "./environment.rb"
require "./app.rb"
require 'capybara/rspec'
require 'test/unit'
require 'nio'


Capybara.app = Sinatra::Application.new

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.javascript_driver = :selenium

RSpec.configure do |config|
  config.include Rack::Test::Methods
  
  config.before(:example) do
    config.run_all_when_everything_filtered = true
    config.filter_run :focus
    config.order = 'random'
    
    # conn = PG.connect(host: 'postgres', dbname: 'postgres', user: 'postgres')
    # conn.exec("
    #   CREATE TABLE TEST (
    #   id SERIAL PRIMARY KEY,
    #   cpf VARCHAR(24) NOT NULL,
    #   nome_paciente VARCHAR(64) NOT NULL,
    #   email_paciente VARCHAR(64) NOT NULL,
    #   data_nascimento_paciente DATE NOT NULL,
    #   endereço_paciente VARCHAR(64) NOT NULL,
    #   cidade_paciente VARCHAR(64) NOT NULL,
    #   estado_paciente VARCHAR(64) NOT NULL,
    #   crm_médico VARCHAR(64) NOT NULL,
    #   crm_médico_estado VARCHAR(64) NOT NULL,
    #   nome_médico VARCHAR(64) NOT NULL,
    #   email_médico VARCHAR(64) NOT NULL,
    #   token_resultado_exame VARCHAR(64) NOT NULL,
    #   data_exame DATE NOT NULL,
    #   tipo_exame VARCHAR(64) NOT NULL,
    #   limites_tipo_exame VARCHAR(64) NOT NULL,
    #   resultado_tipo_exame VARCHAR(64) NOT NULL);
    #  ")
    # conn.close
  
  end
  # config.after(:example) do
  #   conn = PG.connect(host: 'postgres', dbname: 'postgres', user: 'postgres')
  #   conn.exec("DROP TABLE IF EXISTS TEST;")
  #   conn.close
  # end
 
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

 
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end
