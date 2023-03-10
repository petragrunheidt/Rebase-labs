const fragment = new DocumentFragment();
const url = 'http://localhost:3000/api/tests/';
const tokenInput = document.getElementById('token-input');
const tokenButton = document.getElementById('token-button');
const titleDiv = document.getElementById('results-token');
const errorDiv = document.getElementById('error-message');
const errorMessage = document.createElement('h3');
const successDiv = document.getElementById('success-message');
const successMessage = document.createElement('h3');
const thead = document.querySelector('thead');
const tbody = document.querySelector('tbody');
const previous = document.getElementById('previous');
const next = document.getElementById('next');
const pageCount = document.getElementById('page');
const rowOne = document.getElementById('row-token-one')
const rowTwo = document.getElementById('row-token-two')
let page = 1;
let dataLength = 0
setDataLength()

function cleanDisplay() {
  rowOne.innerHTML = '';
  rowTwo.innerHTML = '';
  titleDiv.innerHTML = '';
  tbody.innerHTML = '';
  thead.innerHTML = '';
  errorMessage.remove();
  successMessage.remove();
  next.style = 'display: none;';
  previous.style = 'display: none;';
  pageCount.textContent = '';
}

function setDataLength() {
  fetch('http://localhost:3000/api/tests')
  .then((response) => response.json())
  .then((data) => {dataLength = (Math.ceil(data.length / 100))})
}

function buildTable(page) {
  cleanDisplay()
  fetch(`${url}${page}`).
  then((response) => response.json()).
  then((data) => {
    for (var property in data[0]) {
      const th = document.createElement('th');
      th.scope = "col";
      th.style = "padding-right: 1%;"
      th.textContent = `${property.toUpperCase().replace(/_/g, " ")}`;
      fragment.appendChild(th);
      thead.appendChild(th);
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
      tbody.appendChild(tr);
     }
  }).catch(function(error) {
    console.log(error);
  });
  previous.style = 'background-color: #ffd000; padding: 0.5%;'
  next.style = 'background-color: #ffd000; padding: 0.5%;'
  pageCount.textContent = `P??gina ${page}/${dataLength}`
}

function previousPage() {
  if (page > 1) {
    page -= 1  
    buildTable(page)
  }
}

function nextPage() {
  if (page < dataLength) {
    page += 1  
    buildTable(page)
  }
}

tokenButton.addEventListener('click', function() {
  cleanDisplay()
  const params = tokenInput.value;
  fetch(`http://localhost:3000/api/test/${params}`)
  .then(response => {

    if (response.status === 404) {     
      errorMessage.textContent = 'Token n??o encontrado.';
      errorDiv.appendChild(errorMessage);
    }

    return response.json();
    })
    .then(data => {
      const patientData = Object.fromEntries(Object.entries(data).slice(0,5))
      const medicData = data['m??dico']
      const examsData = data['exames']

      const h2 = document.createElement('h2');
      h2.textContent = `Resultados da busca por: ${data['token']}`
      titleDiv.appendChild(h2);

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
      titleTwo.textContent = "Dados M??dico"
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
    });
});

const fileInput = document.getElementById('file-input');
const importButton = document.getElementById('import-button');

async function readCSV(file) {
  return new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.onload = event => {
      const csv = event.target.result;
      resolve(csv);
    };
    reader.onerror = reject;
    reader.readAsText(file);
  });
}


importButton.addEventListener('click', async () => {
  cleanDisplay()
  const file = fileInput.files[0];
  if (!file) {
    errorMessage.textContent = "Insira um arquivo csv v??lido para importar dados."
    errorDiv.appendChild(errorMessage);
    return;
  }
  const csv = await readCSV(file);
  const csvParsed = csv.replace(' ', '%')
  const response = await fetch(`http://localhost:3000/import`, {
    method: 'POST',
    headers: {
      'Content-Type': 'text/csv',
    },
    body: csvParsed,
  });

  if (response.ok) {
    console.log('Success');
    successMessage.textContent = "Dados Inseridos com Sucesso."
    successDiv.appendChild(successMessage);
  } else {
    console.error('Error');
    errorMessage.textContent = "Erro na Requisi????o."
    errorDiv.appendChild(errorMessage);
  }
});