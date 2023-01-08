require 'sidekiq'
require './queryservice.rb'

class MyJob

  include Sidekiq::Job

  def perform(csv)
    qs = QueryService.new("#{ENV['RACK_ENV']}")   
    qs.insert_values(qs.csv_parse(JSON.parse(csv)), 'EXAM_DATA')
    puts 'success'
  end
end