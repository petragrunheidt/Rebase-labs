require 'spec_helper'

describe 'Server Service' do

  def app
    Sinatra::Application
  end

  it "carrega api com dados de exames" do
    get '/api/tests'
    expect(last_response.status).to eq 200
    expect(last_response.body).to include 'cpf'
    expect(last_response.body).to include 'nome_paciente'

  end

  it "carrega pagina de exibição de dados de exames" do
    get '/tests'
    expect(last_response.status).to eq 200
    # expect(last_response.body).to include 'CPF'
    # expect(last_response.body).to include 'NOME PACIENTE'
    # expect(last_response.body).to include 'EMAIL PACIENTE'
    # expect(last_response.body).to include 'DATA NASCIMENTO PACIENTE'
    # expect(last_response.body).to include 'ENDEREÇO PACIENTE'    
    # expect(last_response.body).to include 'CIDADE PACIENTE'
    # expect(last_response.body).to include 'ESTADO PACIENTE'
    # expect(last_response.body).to include 'CRM MÉDICO'
    # expect(last_response.body).to include 'CRM MÉDICO ESTADO'
    # expect(last_response.body).to include 'NOME MÉDICO'
    # expect(last_response.body).to include 'EMAIL MÉDICO'
    # expect(last_response.body).to include 'TOKEN RESULTADO EXAME'
    # expect(last_response.body).to include 'DATA EXAME'
    # expect(last_response.body).to include 'TIPO EXAME'
    # expect(last_response.body).to include 'LIMITES TIPO EXAME'
    # expect(last_response.body).to include 'RESULTADO TIPO EXAME'
  end
end
