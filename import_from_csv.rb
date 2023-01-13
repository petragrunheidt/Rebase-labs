require_relative 'queryservice.rb'

qs = QueryService.new("development")
qs.delete_database
qs.populate("./data.csv", 'EXAM_DATA')

