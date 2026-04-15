import express, { Application, Request, Response } from "express";

const app: Application = express();

app.get("/", (_: Request, res: Response) => {
    res.send("Hello World!");
});

app.get("/api/healthcheck", (_: Request, res: Response) => {
    res.status(200).send("ok");
});

app.listen(3000, () => {
    console.log("Server is running on port 3000");
});
