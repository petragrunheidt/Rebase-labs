require_relative 'queryservice.rb'

qs = QueryService.new('')
qs.populate("./data.csv", 'EXAM_DATA')
 

