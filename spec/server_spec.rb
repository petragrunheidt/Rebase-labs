require 'spec_helper'

describe 'Server Service' do

  def app
    Sinatra::Application
  end

  it "carrega api com dados de exames" do
    get '/api/tests'
    expect(last_response.status).to eq 200
  end

  it "carrega pagina de exibição de dados de exames" do
    get '/tests'
    expect(last_response.status).to eq 200
  end
end
