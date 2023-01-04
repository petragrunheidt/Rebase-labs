require 'sidekiq'
require './queryservice.rb'

class MyJob
  include Sidekiq::Job

  def perform(csv)
    qs = QueryService.new
    qs.insert_values_no_parse(csv, 'EXAM_DATA')
    puts 'ok'
  end
end