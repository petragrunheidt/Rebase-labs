require 'spec_helper'

describe 'Server Service' do

  def app
    Sinatra::Application
  end

  it "should load the home page" do
    get '/'
    expect(last_response.status).to eq 200
  end

  it "should load the other page" do
    get '/tests'
    expect(last_response.status).to eq 200
  end
end
