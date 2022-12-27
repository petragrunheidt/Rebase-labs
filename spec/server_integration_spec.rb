require 'sinatra'
require 'capybara/rspec'
require './server.rb'

before(:each) do
  
end

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('acessa tabela de dados de exame', {:type => :feature}) do
  it('a partir do banco de dados') do
    visit '/tests'

    expect(page).to have_content 'cpf'
    expect(page).to have_content 'nome_paciente'
    expect(page).to have_content 'email_paciente'
    expect(page).to have_content 'crm_médico'
    expect(page).to have_content 'crm_médico_estado'
    expect(page).to have_content 'nome_médico'
  end
end