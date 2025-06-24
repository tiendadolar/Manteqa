const express = require("express");

const app = express();
const port = 4000;

app.get("/api/hello", (req: any, res: any) => {
  res.json({ message: "Hello, world!" });
});

app.listen(port, () => {
  console.log(`Server running ${port}`);
});

module.exports = app;
