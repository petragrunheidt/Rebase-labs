require 'pg'
require 'csv'

class QueryService
  
  def initialize
    @conn = PG.connect(host: 'postgres', dbname: 'postgres', user: 'postgres')
  end

  def populate
    create_table
    insert_values
    @conn.close
  end

  def create_table
    @conn.exec("DROP TABLE IF EXISTS EXAM_DATA;")
    @conn.exec("
              CREATE TABLE EXAM_DATA (
              id SERIAL PRIMARY KEY,
              cpf VARCHAR(24) NOT NULL,
              nome_paciente VARCHAR(64) NOT NULL,
              email_paciente VARCHAR(64) NOT NULL,
              data_nascimento_paciente DATE NOT NULL,
              endereço_paciente VARCHAR(64) NOT NULL,
              cidade_paciente VARCHAR(64) NOT NULL,
              estado_paciente VARCHAR(64) NOT NULL,
              crm_médico VARCHAR(64) NOT NULL,
              crm_médico_estado VARCHAR(64) NOT NULL,
              nome_médico VARCHAR(64) NOT NULL,
              email_médico VARCHAR(64) NOT NULL,
              token_resultado_exame VARCHAR(64) NOT NULL,
              data_exame DATE NOT NULL,
              tipo_exame VARCHAR(64) NOT NULL,
              limites_tipo_exame VARCHAR(64) NOT NULL,
              resultado_tipo_exame VARCHAR(64) NOT NULL);
             ")
  end

  def insert_values
    csv_parse.each do |row_insert|
      @conn.exec("
        INSERT INTO EXAM_DATA (cpf, nome_paciente, email_paciente, data_nascimento_paciente,
                               endereço_paciente, cidade_paciente, estado_paciente, crm_médico,
                               crm_médico_estado, nome_médico, email_médico, token_resultado_exame,
                               data_exame, tipo_exame, limites_tipo_exame, resultado_tipo_exame)
        VALUES ('#{row_insert['cpf']}\', '#{row_insert['nome paciente']}\', '#{row_insert['email paciente']}\', '#{row_insert['data nascimento paciente']}\',
                '#{row_insert['endereço paciente']}\', '#{@conn.escape_string(row_insert['cidade paciente'])}\', '#{row_insert['estado paciente']}\','#{row_insert['crm médico']}\',
                '#{row_insert['crm médico estado']}\', '#{row_insert['nome médico']}\', '#{row_insert['email médico']}\', '#{row_insert['token resultado exame']}\',
                '#{row_insert['data exame']}\', '#{row_insert['tipo exame']}\', '#{row_insert['limites tipo exame']}\', '#{row_insert['resultado tipo exame']}\');
        ")
    end
  end

  def csv_parse
    rows = CSV.read("./data.csv", col_sep: ';')
    columns = rows.shift

    rows.map do |row|
      row.each_with_object({}).with_index do |(cell, acc), idx|
        column = columns[idx]
        acc[column] = cell
      end
    end
  end
end

QueryService.new.populate