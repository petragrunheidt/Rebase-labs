require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require 'sinatra/activerecord'
require 'pg'
require_relative 'queryservice'

get '/tests' do
  QueryService.populate
  exam_table = QueryService.all

  return exam_table.to_json
end

get '/hello' do
  'Hello world!'
end

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)
