require_relative 'queryservice.rb'

# QueryService.new.populate("./data.csv", 'EXAM_DATA')

lala = 'cpf;nome paciente;email paciente;data nascimento paciente;endereço paciente;cidade paciente;estado paciente;crm médico;crm médico estado;nome médico;email médico;token resultado exame;data exame;tipo exame;limites tipo exame;resultado tipo exame
048.973.170-88;test teste testinha;teste@teste-quigley.com;2001-03-11;165 Rua Rafaela;Ituverava;Alagoas;B000BJ20J4;PI;Maria Luiza Pires;denna@wisozk.biz;TEST50;2021-08-05;hemácias;45-52;97
048.973.170-88;test teste testinha;teste@teste-quigley.com;2001-03-11;165 Rua Rafaela;Ituverava;Alagoas;B000BJ20J4;PI;Maria Luiza Pires;denna@wisozk.biz;TEST50;2021-08-05;leucócitos;9-61;89
048.973.170-88;test teste testinha;teste@teste-quigley.com;2001-03-11;165 Rua Rafaela;Ituverava;Alagoas;B000BJ20J4;PI;Maria Luiza Pires;denna@wisozk.biz;TEST50;2021-08-05;plaquetas;11-93;97'

lili = 'cpf;nome paciente;email paciente;data nascimento paciente;endereço paciente;cidade paciente;estado paciente;crm médico;crm médico estado;nome médico;email médico;token resultado exame;data exame;tipo exame;limites tipo exame;resultado tipo exame
048.973.170-88;test teste testinha;teste@teste-quigley.com;2001-03-11;165 Rua Rafaela;Ituverava;Alagoas;B000BJ20J4;PI;Maria Luiza Pires;denna@wisozk.biz;TEST50;2021-08-05;hemácias;45-52;97
048.973.170-88;test teste testinha;teste@teste-quigley.com;2001-03-11;165 Rua Rafaela;Ituverava;Alagoas;B000BJ20J4;PI;Maria Luiza Pires;denna@wisozk.biz;TEST50;2021-08-05;leucócitos;9-61;89
048.973.170-88;test teste testinha;teste@teste-quigley.com;2001-03-11;165 Rua Rafaela;Ituverava;Alagoas;B000BJ20J4;PI;Maria Luiza Pires;denna@wisozk.biz;TEST50;2021-08-05;plaquetas;11-93;97'

puts QueryService.new.csv_parse_read("./spec/support/small_test_data.csv") == QueryService.new.csv_parse(lala) 

