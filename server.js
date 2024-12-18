const express = require("express");

const app = express();

app.get("/", (req, res) => {
    res.send("Hello World!");
});

app.get("/api/healthcheck", (_, res) => {
    res.status(200).send("ok");
});

app.listen(3000, () => {
    console.log("Server is running on port 3000");
});
