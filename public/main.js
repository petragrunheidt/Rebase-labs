const fragment = new DocumentFragment();
const url = 'http://localhost:3000/api/tests/';

var page = 1

function buildTable(page) {
  fetch(`${url}${page}`).
  then((response) => response.json()).
  then((data) => {
    for (var property in data[0]) {
      const th = document.createElement('th');
      th.scope = "col";
      th.style = "padding-right: 1%;"
      th.textContent = `${property.toUpperCase().replace(/_/g, " ")}`;
      fragment.appendChild(th);
      document.querySelector('thead').appendChild(th);
    }  
    for (var i = 0; i < data.length; i++) {

      const tr = document.createElement('tr');
      tr.id = i;   
      for (var property in data[i]) {
        const td = document.createElement('td');      
        td.textContent = `${data[i][property]}`;
        fragment.appendChild(td);
      }
      tr.appendChild(fragment)
      document.querySelector('tbody').appendChild(tr);
     }
  }).catch(function(error) {
    console.log(error);
  });
  const button = document.getElementById('full-data')
  button.remove();
}


const tokenInput = document.getElementById('token-input');
const tokenButton = document.getElementById('token-button');
const error = document.getElementById('error-message');


tokenButton.addEventListener('click', function() {
  const params = tokenInput.value;
  fetch(`http://localhost:3000/api/test/${params}`)
  .then(response => {

    if (response.status === 404) {     
      error.textContent = 'token não encontrado.';
      document.getElementById('results-token').appendChild(error);
    }

    return response.json();
    })
    .then(data => {
      const patientData = Object.fromEntries(Object.entries(data).slice(0,5))
      const medicData = data['médico']
      const examsData = data['exames']

      titleDiv = document.getElementById('results-token')
      const h2 = document.createElement('h2');
      h2.textContent = `Resultados da busca por: ${data['token']}`
      titleDiv.appendChild(h2);
      
      rowOne = document.getElementById('row-token-one')
      rowTwo = document.getElementById('row-token-two')

      const colOne = document.createElement('div')
      colOne.class = "col-4" 
      const cardOne = document.createElement('div')
      cardOne.class = "card"
      cardOne.style = "width: 30%; background-color: #8848ff; padding: 3%;"
      const titleOne = document.createElement('h3')
      cardOne.appendChild(titleOne)
      titleOne.class = "card-title"
      titleOne.textContent = "Dados Paciente"
      const dlOne = document.createElement('dl')
      cardOne.appendChild(dlOne)
      colOne.appendChild(cardOne)
      rowOne.appendChild(colOne)

      const colTwo = document.createElement('div')
      colTwo.class = "col-4"
      const cardTwo = document.createElement('div')
      cardTwo.class = "card"
      cardTwo.style = "width: 30%; background-color: #8848ff; padding: 3%;"
      const titleTwo = document.createElement('h3')
      cardTwo.appendChild(titleTwo)
      titleTwo.class = "card-title"
      titleTwo.textContent = "Dados Médico"
      const dlTwo = document.createElement('dl')
      cardTwo.appendChild(dlTwo)
      colTwo.appendChild(cardTwo)
      rowOne.appendChild(colTwo)
      
      const colThree = document.createElement('div')
      colThree.class = "col-4"
      const cardThree = document.createElement('div')
      cardThree.class = "card"
      cardThree.style = "width: 30%; background-color: #8848ff; padding: 3%;"
      const titleThree = document.createElement('h3')
      cardThree.appendChild(titleThree)
      titleThree.class = "card-title"
      titleThree.textContent = "Dados de Exames"
      const dlThree = document.createElement('dl')
      cardThree.appendChild(dlThree)
      colThree.appendChild(cardThree)
      rowTwo.appendChild(colThree)

     
      for (var property in patientData) {
        const p = document.createElement('p')
        p.textContent = `${property.toUpperCase()}: ${patientData[property]}`
        dlOne.appendChild(p)
      };
      for (var property in medicData) {
        const p = document.createElement('p')
        p.textContent = `${property.toUpperCase()}: ${medicData[property]}`
        dlTwo.appendChild(p)
      }
      for (var i = 0; i < examsData.length; i++) {
        hr = document.createElement('hr')
        dlThree.appendChild(hr)
        for (var property in examsData[i]) {
          const p = document.createElement('p')
          p.textContent = `${property.toUpperCase()}: ${examsData[i][property]}`
          dlThree.appendChild(p)
        }}

      const button = document.getElementById('full-data')
      button.remove();
      error.remove();
    });
});

function post() {
  fetch('http://localhost:3000/import', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
  },
    body: JSON.stringify({
      name: 'John',
      email: 'john@example.com'
    })
  })
  .then(response => response.json())
  .then(data => console.log(data));
}
