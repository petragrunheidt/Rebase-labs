require 'spec_helper'
require './queryservice.rb'

describe 'QueryService' do

  def app
    Sinatra::Application
  end

  it "metodo insert_values insere dados a partir de arquivo csv" do
    conn = PG.connect(host: 'postgres', dbname: 'postgres', user: 'postgres')
    qs = QueryService.new
    qs.create_table('TEST')
    qs.insert_values(qs.csv_parse("./spec/support/small_test_data.csv"),"TEST")
    result = conn.exec("SELECT * FROM TEST").to_a
    
    expect(result.length).to eq 3
    expect(result[0]).to include 'cpf'
    expect(result[0]).to include 'nome_paciente'
    expect(result[0]).to include 'email_paciente'
    expect(result[0]).to include 'data_nascimento_paciente'
    expect(result[0]).to include 'endereço_paciente'
    expect(result[0]).to include 'cidade_paciente'
    expect(result[0]).to include 'estado_paciente'
    expect(result[0]).to include 'crm_médico'
    expect(result[0]).to include 'crm_médico_estado'
    expect(result[0]).to include 'nome_médico'
    expect(result[0]).to include 'email_médico'
    expect(result[0]).to include 'token_resultado_exame'
    expect(result[0]).to include 'data_exame'
    expect(result[0]).to include 'tipo_exame'
    expect(result[0]).to include 'limites_tipo_exame'
    expect(result[0]).to include 'resultado_tipo_exame'
  end

  it "metodo populate cria tabela e insere dados a partir de arquivo csv" do
    conn = PG.connect(host: 'postgres', dbname: 'postgres', user: 'postgres')
    qs = QueryService.new
    qs.populate("./spec/support/small_test_data.csv","TEST")
    result = conn.exec("SELECT * FROM TEST").to_a
    
    expect(result.length).to eq 3
    expect(result[0]).to include 'cpf'
    expect(result[0]).to include 'nome_paciente'
    expect(result[0]).to include 'email_paciente'
    expect(result[0]).to include 'data_nascimento_paciente'
    expect(result[0]).to include 'endereço_paciente'
    expect(result[0]).to include 'cidade_paciente'
    expect(result[0]).to include 'estado_paciente'
    expect(result[0]).to include 'crm_médico'
    expect(result[0]).to include 'crm_médico_estado'
    expect(result[0]).to include 'nome_médico'
    expect(result[0]).to include 'email_médico'
    expect(result[0]).to include 'token_resultado_exame'
    expect(result[0]).to include 'data_exame'
    expect(result[0]).to include 'tipo_exame'
    expect(result[0]).to include 'limites_tipo_exame'
    expect(result[0]).to include 'resultado_tipo_exame'
  end
end