require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'rack/handler/puma'
require 'csv'
require 'sinatra/activerecord'
require 'pg'
require_relative 'queryservice'
also_reload('lib/**/*.rb')

get '/tests' do
  send_file './views/tests.html'
end

get '/api/tests' do
  conn = PG.connect(host: 'postgres', dbname: 'postgres', user: 'postgres')
  exam_table = conn.exec("SELECT * FROM EXAM_DATA").to_a

  json_data = exam_table.to_json
  return json_data
end

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)
