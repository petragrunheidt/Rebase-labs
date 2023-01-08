require 'sinatra'
require 'pg'
require_relative 'queryservice'
require './app/jobs/my_job'
require 'json'

ENV['RACK_ENV'] = 'development' 

get '/' do
  send_file './views/tests.html'

end

get '/api/tests' do
  exam_table = QueryService.new("#{ENV['RACK_ENV']}").all('EXAM_DATA')
  return exam_table.to_json
end

get '/api/tests/:page' do
  selection = params['page'].to_i * 100
  exam_table = QueryService.new("#{ENV['RACK_ENV']}").query_interval('EXAM_DATA', selection - 100, selection - 1)
  return exam_table.to_json
end

get '/api/test/:token' do
  exam_table = QueryService.new("#{ENV['RACK_ENV']}").select_by_token('EXAM_DATA', params['token'])
  return exam_table.to_json
end

post '/import' do 
  csv = request.body.read.gsub('%', ' ').to_json
  MyJob.perform_async(csv)
end