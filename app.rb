require 'sinatra'
require 'pg'
require_relative 'queryservice'
require './app/jobs/my_job'
require 'json'

get '/' do
  send_file './views/tests.html'

end

get '/api/tests' do
  exam_table = QueryService.new("#{ENV['RACK_ENV']}").all('EXAM_DATA')
  return exam_table.to_json
end

get '/api/tests/:page' do
  selection = params['page'].to_i * 100
  qs = QueryService.new("#{ENV['RACK_ENV']}")
  page_data = qs.query_interval('EXAM_DATA', selection - 100, selection - 1)
  return page_data.to_json
end

get '/api/test/:token' do
  exam_table = QueryService.new("#{ENV['RACK_ENV']}").select_by_token('EXAM_DATA', params['token'])
  return exam_table.to_json
end

post '/import' do 
  csv = request.body.read.gsub('%', ' ').to_json
  MyJob.perform_async(csv)
end