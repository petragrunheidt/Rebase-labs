fetch('http://localhost:3000').
  then((response) => console.log(response.status)).
  then((data) => {console.log(data)});