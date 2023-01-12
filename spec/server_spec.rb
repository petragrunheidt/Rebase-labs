require 'spec_helper'
require './queryservice.rb'

describe 'Server Service' do

  def app
    Sinatra::Application
  end


  it "carrega pagina de exibição de dados de exames" do
    get '/'
    expect(last_response.status).to eq 200
  end

  it "carrega api com dados completos de exames" do
    qs = QueryService.new("#{ENV['RACK_ENV']}")
    qs.insert_values(qs.csv_parse('./spec/support/small_test_data.csv'), 'EXAM_DATA')
    get '/api/tests'
    expect(last_response.status).to eq 200
    expect(last_response.body).to include 'cpf'
    expect(last_response.body).to include 'nome_paciente'
    expect(last_response.body).to include 'email_paciente'
    expect(last_response.body).to include 'data_nascimento_paciente'
    expect(last_response.body).to include 'endereço_paciente'
    expect(last_response.body).to include 'cidade_paciente'
    expect(last_response.body).to include 'estado_paciente'
    expect(last_response.body).to include 'crm_médico'
    expect(last_response.body).to include 'crm_médico_estado'
    expect(last_response.body).to include 'nome_médico'
    expect(last_response.body).to include 'email_médico'
    expect(last_response.body).to include 'token_resultado_exame'
    expect(last_response.body).to include 'data_exame'
    expect(last_response.body).to include 'tipo_exame'
    expect(last_response.body).to include 'limites_tipo_exame'
    expect(last_response.body).to include 'resultado_tipo_exame'

  end

  it 'carrega api com dados das 100 primeiras entradas do banco de dados' do
    qs = QueryService.new("#{ENV['RACK_ENV']}")
    qs.insert_values(qs.csv_parse('./spec/support/big_test_data.csv'), 'EXAM_DATA')
    get '/api/tests/1'
    expect(last_response.status).to eq 200
    expect(JSON.parse(last_response.body).length).to eq 100
  end

  it "carrega api com dados de um token" do
    qs = QueryService.new("#{ENV['RACK_ENV']}")
    qs.insert_values(qs.csv_parse('./spec/support/small_test_data.csv'), 'EXAM_DATA')
    get '/api/test/TEST33'

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
    qs = QueryService.new("#{ENV['RACK_ENV']}")
    small_csv_data = 'cpf;nome paciente;email paciente;data nascimento paciente;endereço paciente;cidade paciente;estado paciente;crm médico;crm médico estado;nome médico;email médico;token resultado exame;data exame;tipo exame;limites tipo exame;resultado tipo exame
    048.973.170-88;test teste testinha;teste@teste-quigley.com;2001-03-11;165 Rua Rafaela;Ituverava;Alagoas;B000BJ20J4;PI;Maria Luiza Pires;denna@wisozk.biz;TEST42;2021-08-05;hemácias;45-52;97
    048.973.170-88;test teste testinha;teste@teste-quigley.com;2001-03-11;165 Rua Rafaela;Ituverava;Alagoas;B000BJ20J4;PI;Maria Luiza Pires;denna@wisozk.biz;TEST42;2021-08-05;leucócitos;9-61;89
    048.973.170-88;test teste testinha;teste@teste-quigley.com;2001-03-11;165 Rua Rafaela;Ituverava;Alagoas;B000BJ20J4;PI;Maria Luiza Pires;denna@wisozk.biz;TEST42;2021-08-05;plaquetas;11-93;97'
    post '/import', body: small_csv_data.gsub(' ', '%')
    expect(last_response.status).to eq 200
    expect(ENV['RACK_ENV']).to eq 'test'
    expect(qs.all('EXAM_DATA')).to eq 3
  end
end
