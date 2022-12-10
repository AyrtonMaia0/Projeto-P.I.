const fs = require("fs");

fs.readFile("./example.csv", "utf8", function (err, data) {
  console.log(data);
});

// CSV string output:
// Name, Age, Country
// Jack, 22, Australia
// Jane, 27, United Kingdom