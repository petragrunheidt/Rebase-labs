const url = 'http://localhost:3000/api/tests';

fetch(url).
  then((response) => response.json()).
  then((data) => {console.log(data)})

