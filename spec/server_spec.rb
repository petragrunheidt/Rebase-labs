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
    small_csv_data = 'cpf;nome paciente;email paciente;data nascimento paciente;endereço paciente;cidade paciente;estado paciente;crm médico;crm médico estado;nome médico;email médico;token resultado exame;data exame;tipo exame;limites tipo exame;resultado tipo exame
    048.973.170-88;test teste testinha;teste@teste-quigley.com;2001-03-11;165 Rua Rafaela;Ituverava;Alagoas;B000BJ20J4;PI;Maria Luiza Pires;denna@wisozk.biz;TEST42;2021-08-05;hemácias;45-52;97
    048.973.170-88;test teste testinha;teste@teste-quigley.com;2001-03-11;165 Rua Rafaela;Ituverava;Alagoas;B000BJ20J4;PI;Maria Luiza Pires;denna@wisozk.biz;TEST42;2021-08-05;leucócitos;9-61;89
    048.973.170-88;test teste testinha;teste@teste-quigley.com;2001-03-11;165 Rua Rafaela;Ituverava;Alagoas;B000BJ20J4;PI;Maria Luiza Pires;denna@wisozk.biz;TEST42;2021-08-05;plaquetas;11-93;97'
    post '/import', body: small_csv_data.gsub(' ', '%')
    expect(last_response.status).to eq 200
  end
end
