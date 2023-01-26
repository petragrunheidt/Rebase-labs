require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require_relative 'queryservice'
require './app.rb'

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)
