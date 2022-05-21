import express from "express";
import { APP_PORT, MONGOURI } from "./config";
import mongoose from "mongoose";
import bodyParser from "body-parser";
import routes from "./routes";
import errorHandler from "./middlewares/errorHandler";


const app = express();

//Connecting to the database
mongoose.connect(MONGOURI, { useNewUrlParser: true, useUnifiedTopology: true });
const db = mongoose.connection;
db.on('error', console.error.bind(console, 'connection error:'));
db.once('open', () => {
    console.log('DB connected');
});

// Getting data in json format
app.use(
    bodyParser.urlencoded({
      extended: true,
    })
);
app.use(bodyParser.json({ type: "application/json" }));

// Setting express engine
app.set("view engine", "ejs");
app.use(express.static("public"));

app.use("/", routes);

app.use(errorHandler);

// Starting the server
app.listen(APP_PORT || 3000, () => {
    console.log(`Server started on port ${APP_PORT || 3000}`);
});