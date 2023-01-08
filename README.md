# Rebase Labs

Uma app web para listagem de exames médicos.

## Tech Stack

* Docker
* Ruby
* Javascript
* HTML
* CSS

## Sumário
   
  * [Como rodar a aplicação](#como-rodar-a-aplicação)
  * [Documentação de APIs](#Documentação-de-APIs)

## Como rodar a aplicação

Com Docker Compose instalado em seu sistema, rode o comando  `docker compose -d up` para iniciar a aplicação inicial e em seguida rode o comando `docker exec app ruby import_from_csv.rb` para popular o banco de dados.

A partir desse ponto será possível acessar a aplicação pelo endereço `https://localhost:3000/`

Caso queira rodar todos os testes automatizados, utilize o comando  `docker exec app rspec`

## Documentação de APIs

A aplicação apresenta 4 endpoints para exibição dos dados importados de arquivos csv:

### Listagem de Todos os Dados Brutos

Para obter a listagem de todos dados do sistema, você pode fazer uma requisição com o verbo `GET` na seguinte URL:

`https://localhost:3000/api/tests`

Exemplo de dados:

```json
[{
   "token_resultado_exame":"IQCZ17","data_exame":"2021-08-05","cpf":"048.973.170-88","nome_paciente":"Emilly Batista Neto","email_paciente":"gerald.crona@ebert-quigley.com","data_nascimento_paciente":"2001-03-11","crm_médico":"B000BJ20J4","crm_médico_estado":"PI","nome_médico":"Maria Luiza Pires","tipo_exame":"hemácias","limites_tipo_exame":"45-52","resultado_tipo_exame":"97"
}]
```

### Listagem de Todos os Dados Brutos com paginação

Para obter a listagem de 100 em 100 de todos dados do sistema, você pode fazer uma requisição com o verbo `GET` na seguinte URL:

`https://localhost:3000/api/tests/:page`

Em que `:page` deve ser substituído por um número, sendo que o número 1 lista as primeiras 100 entradas, o número 2 lista as entradas de número 101 a 200 e assim por diante.

Exemplo de dados:

```json
[{
   "token_resultado_exame":"IQCZ17","data_exame":"2021-08-05","cpf":"048.973.170-88","nome_paciente":"Emilly Batista Neto","email_paciente":"gerald.crona@ebert-quigley.com","data_nascimento_paciente":"2001-03-11","crm_médico":"B000BJ20J4","crm_médico_estado":"PI","nome_médico":"Maria Luiza Pires","tipo_exame":"hemácias","limites_tipo_exame":"45-52","resultado_tipo_exame":"97"
}]
```

### Listagem de Todos os Dados Brutos com paginação

Para obter a listagem de 100 em 100 de todos dados do sistema, você pode fazer uma requisição com o verbo `GET` na seguinte URL:

`https://localhost:3000/api/tests/:page`

Em que `:page` deve ser substituído por um número, sendo que o número 1 lista as primeiras 100 entradas, o número 2 lista as entradas de número 101 a 200 e assim por diante.

Exemplo de dados:

```json
[{
   "token_resultado_exame":"IQCZ17","data_exame":"2021-08-05","cpf":"048.973.170-88","nome_paciente":"Emilly Batista Neto","email_paciente":"gerald.crona@ebert-quigley.com","data_nascimento_paciente":"2001-03-11","crm_médico":"B000BJ20J4","crm_médico_estado":"PI","nome_médico":"Maria Luiza Pires","tipo_exame":"hemácias","limites_tipo_exame":"45-52","resultado_tipo_exame":"97"
}]
```


### Listagem de Dados de Exame de um Paciente a Partir do Token

Para obter dados já processados e organizados de exames de um paciente, você pode fazer uma requisição com o verbo `GET` na seguinte URL:

`https://localhost:3000/api/tests/:token`

Em que `:token` deve ser substituído pelo token do exame.

Exemplo de dados:

```json
{
   "token":"IQCZ17","data":"2021-08-05","cpf":"048.973.170-88","nome":"Emilly Batista Neto","email":"gerald.crona@ebert-quigley.com","data_de_nascimento":"2001-03-11","médico":{"crm":"B000BJ20J4","estado":"PI","nome":"Maria Luiza Pires"},"exames":[{"tipo":"hemácias","limites":"45-52","resultados":"97"},{"tipo":"leucócitos","limites":"9-61","resultados":"89"},{"tipo":"plaquetas","limites":"11-93","resultados":"97"},{"tipo":"hdl","limites":"19-75","resultados":"0"},{"tipo":"ldl","limites":"45-54","resultados":"80"},{"tipo":"vldl","limites":"48-72","resultados":"82"},{"tipo":"glicemia","limites":"25-83","resultados":"98"},{"tipo":"tgo","limites":"50-84","resultados":"87"},{"tipo":"tgp","limites":"38-63","resultados":"9"},{"tipo":"eletrólitos","limites":"2-68","resultados":"85"},{"tipo":"tsh","limites":"25-80","resultados":"65"},{"tipo":"t4-livre","limites":"34-60","resultados":"94"},{"tipo":"ácido úrico","limites":"15-61","resultados":"2"}]
}
```

### Rota para inserção de dados no sistema

Para inserir dados de exames no sistema, deve ser feita uma requisição com o verbo `POST` na seguinte URL:

`https://localhost:3000/import`

Porém, essa rota está configurada para receber um arquivo csv a partir de um botão na pagina inicial da aplicação.