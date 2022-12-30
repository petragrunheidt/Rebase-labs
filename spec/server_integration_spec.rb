require 'spec_helper'

describe 'test if it works', {:type => :feature} do
  it 'acess tests' do
    visit '/tests'
    expect(page).to have_content 'Tabela de Dados de Exames'
  end
end


