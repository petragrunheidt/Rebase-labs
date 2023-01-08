require_relative 'queryservice.rb'

qs = QueryService.new("development")
qs.populate("./data.csv", 'EXAM_DATA')


