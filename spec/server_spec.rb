require 'spec_helper'

describe 'Server Service' do

  def app
    Sinatra::Application
  end


  it "carrega pagina de exibição de dados de exames" do
    get '/'
    expect(last_response.status).to eq 200
  end

  it "carrega api com dados completos de exames" do
    get '/api/tests'
    expect(last_response.status).to eq 200
    expect(last_response.body).to include 'cpf'
    expect(last_response.body).to include 'nome_paciente'
  end

  it "carrega api com dados de um token" do
    get '/api/test/IQCZ17'

    expect(last_response.status).to eq 200
    expect(last_response.body).to include 'token'
    expect(last_response.body).to include 'data'
    expect(last_response.body).to include 'cpf'
    expect(last_response.body).to include 'nome'
    expect(last_response.body).to include 'email'
    expect(last_response.body).to include 'data_de_nascimento'
    expect(last_response.body).to include 'médico'
    expect(last_response.body).to include 'exames'
  end

  it "faz post em /import, inserindo dados na tabela de dados de exames" do
    post '/import'
    expect(last_response.status).to eq 200
  end
end
