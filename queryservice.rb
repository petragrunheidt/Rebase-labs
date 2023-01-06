require 'pg'
require 'csv'

class QueryService
  
  def initialize
    @conn = PG.connect(host: 'postgres', dbname: 'postgres', user: 'postgres')
  end

  def all(table_name)
    @conn.exec("SELECT token_resultado_exame, data_exame, cpf, nome_paciente,
        email_paciente, data_nascimento_paciente, crm_médico, crm_médico_estado,
        nome_médico, tipo_exame, limites_tipo_exame, resultado_tipo_exame FROM #{table_name}").to_a
  end

  def query_interval(table_name, first, last)
    @conn.exec("SELECT token_resultado_exame, data_exame, cpf, nome_paciente,
       email_paciente, data_nascimento_paciente, crm_médico, crm_médico_estado,
       nome_médico, tipo_exame, limites_tipo_exame, resultado_tipo_exame FROM #{table_name}").to_a[first..last]
  end

  def select_by_token(table_name, token)
    table = @conn.exec("SELECT token_resultado_exame, data_exame, cpf, nome_paciente,
        email_paciente, data_nascimento_paciente, crm_médico, crm_médico_estado,
        nome_médico, tipo_exame, limites_tipo_exame, resultado_tipo_exame FROM #{table_name} WHERE token_resultado_exame = '#{token}'").to_a
    
    doctor_data = {crm: table[0]['crm_médico'], estado: table[0]['crm_médico_estado'], nome: table[0]['nome_médico']}    
    exams = [] 
    table.each { |entry| exams << {tipo: entry['tipo_exame'], limites: entry['limites_tipo_exame'], resultados: entry['resultado_tipo_exame']}}    
    
    return {token: table[0]['token_resultado_exame'],
            data: table[0]['data_exame'],
            cpf: table[0]['cpf'],
            nome: table[0]['nome_paciente'],
            email: table[0]['email_paciente'],
            data_de_nascimento: table[0]['data_nascimento_paciente'],
            médico: doctor_data,
            exames: exams}
  end

  def populate(path, table_name)
    create_table(table_name)
    insert_values(csv_parse_read(path), table_name)
  end

  def create_table(table_name)
    @conn.exec("DROP TABLE IF EXISTS #{table_name};")
    @conn.exec("
              CREATE TABLE #{table_name} (
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

  def insert_values(csv, table_name)
    puts csv
    csv.each do |row_insert|
      @conn.exec("
        INSERT INTO #{table_name} (cpf, nome_paciente, email_paciente, data_nascimento_paciente,
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

  def csv_parse_read(path)
    rows = CSV.read(path, col_sep: ';')
    columns = rows.shift

    rows.map do |row|
      row.each_with_object({}).with_index do |(cell, acc), idx|
        column = columns[idx]
        acc[column] = cell
      end
    end
  end

  def csv_parse(csv_string)
    rows = CSV.parse(csv_string, col_sep: ';')
    columns = rows.shift

    rows.map do |row|
      row.each_with_object({}).with_index do |(cell, acc), idx|
        column = columns[idx]
        acc[column] = cell
      end
    end
  end

  def exit
    @conn.close
  end
end


