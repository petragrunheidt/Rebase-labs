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
  const button = document.getElementById('start')
  button.remove();
}


const tokenInput = document.getElementById('token-input');
const tokenButton = document.getElementById('token-button');


tokenButton.addEventListener('click', function() {
  const params = tokenInput.value;
  fetch(`http://localhost:3000/api/test/${params}`)
    .then(response => response.json())
    .then(data => {
      const patientData = Object.fromEntries(Object.entries(data).slice(0,5))
      const medicData = data['médico']
      const examsData = data['exames']

      div = document.getElementById('results-token')
      const h2 = document.createElement('h2');
      h2.textContent = `Resultados da busca por: ${data['token']}`
      div.appendChild(h2);
      const dl = document.createElement('dl')
     
      for (var property in patientData) {
        const dt = document.createElement('dt')
        dt.textContent = `${property}: ${patientData[property]}`
        dl.appendChild(dt)
      };
      for (var property in medicData) {
        const dt = document.createElement('dt')
        dt.textContent = `${property}: ${medicData[property]}`
        dl.appendChild(dt)
      }
      for (var i = 0; i < examsData.length; i++) {
        for (var property in examsData[i]) {
          const dt = document.createElement('dt')
          dt.textContent = `${property}: ${examsData[i][property]}`
          dl.appendChild(dt)
        }}
      div.appendChild(dl);
    });
});