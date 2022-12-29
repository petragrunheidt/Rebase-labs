require 'sinatra'
require 'pg'
require_relative 'queryservice'

get '/tests' do
  send_file './views/tests.html'
end

get '/api/tests' do
  conn = PG.connect(host: 'postgres', dbname: 'postgres', user: 'postgres')
  exam_table = conn.exec("SELECT * FROM EXAM_DATA").to_a

  json_data = exam_table.to_json
  return json_data
end