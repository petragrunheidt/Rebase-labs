require 'sinatra'
require 'pg'
require_relative 'queryservice'
require './app/jobs/my_job'
require 'uri'

get '/' do
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

post '/import' do #csv também pode ser passado por params
  if params[:csv_file] && params[:csv_file][:filename]
    csv = params[:csv_file][:tempfile]
    data = QueryService.new.csv_parse(csv)
    MyJob.perform_async(data)
  end
  # csv = URI.unescape(params['file'])
  # csv = request.body.read  
  'ok'
end