require 'sinatra'
require 'pg'
require_relative 'queryservice'

get '/tests' do
  send_file './views/tests.html'
end

get '/api/tests' do
  exam_table = QueryService.new.all('EXAM_DATA')
  return exam_table.to_json
end

get '/api/tests/:page' do
  selection = params['page'].to_i * 100
  exam_table = QueryService.new.query_interval('EXAM_DATA', selection - 100, selection - 1)
  return exam_table.to_json
end

get '/api/test/:token' do
  exam_table = QueryService.new.select_by_token('EXAM_DATA', params['token'])
  return exam_table.to_json
end