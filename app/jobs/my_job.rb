require 'sidekiq'
require './queryservice.rb'

class MyJob
  Sidekiq.strict_args!(false)
  include Sidekiq::Job

  def perform(csv)
    qs = QueryService.new   
    qs.insert_values(qs.csv_parse(csv), 'EXAM_DATA')
    puts 'success'
  end
end