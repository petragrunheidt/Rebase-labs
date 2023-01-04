require 'spec_helper'
require './queryservice.rb'


# describe 'test if it works', {:type => :feature} do  
#   before(:all) do
#     Capybara.current_driver = :selenium
    
#     #QueryService.new.populate("./data.csv", 'EXAM_DATA')
#   end
#   it 'acess tests' do    
#     visit '/tests'
#     click_on 'Carregar dados de Exames'
#     page.find('div.rspec-wait', wait: 10)
#     expect(page).to have_content 'Tabela de Dados de Exames'
#     expect(page).to have_content 'CPF'
#     expect(page).to have_content 'NOME PACIENTE'
#     expect(page).to have_content 'EMAIL PACIENTE'
#     expect(page).to have_content 'DATA NASCIMENTO PACIENTE'
#     expect(page).to have_content 'ENDEREÇO PACIENTE'    
#     expect(page).to have_content 'CIDADE PACIENTE'
#     expect(page).to have_content 'ESTADO PACIENTE'
#     expect(page).to have_content 'CRM MÉDICO'
#     expect(page).to have_content 'CRM MÉDICO ESTADO'
#     expect(page).to have_content 'NOME MÉDICO'
#     expect(page).to have_content 'EMAIL MÉDICO'
#     expect(page).to have_content 'TOKEN RESULTADO EXAME'
#     expect(page).to have_content 'DATA EXAME'
#     expect(page).to have_content 'TIPO EXAME'
#     expect(page).to have_content 'LIMITES TIPO EXAME'
#     expect(page).to have_content 'RESULTADO TIPO EXAME'
#   end
#   after(:all) do
#     Capybara.use_default_driver
#   end
# end


