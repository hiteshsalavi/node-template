import express, { Application, NextFunction, Request, Response } from "express";

import { WrapController } from "./helpers/wrap.controller.helper"

const app: Application = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.get("/error-endpoint", WrapController(async (_: Request, res: Response) => {
    throw new Error("Test error handling");
}));

app.get("/api/healthcheck", WrapController(async (_: Request, res: Response, next: NextFunction) => {
    res.status(200).send("ok");
}));

app.use((err: Error, req: Request, res: Response, next: NextFunction) => {
    console.error(err.stack);
    res.status(500).json({ error: "Something went wrong!" });
});

app.listen(3000, () => {
    console.log("Server is running on port 3000");
});
