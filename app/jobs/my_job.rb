require 'sidekiq'
require './queryservice.rb'

class MyJob

  include Sidekiq::Job

  def perform(csv)
    qs = QueryService.new   
    qs.insert_values(qs.csv_parse(JSON.parse(csv)), 'EXAM_DATA')
    puts 'success'
  end
end