var test = document.querySelector("#test")
fetch("http://localhost:3000/api/tests").then((response) => response.json()).then((data) => test.textContent = data);
