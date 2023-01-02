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

