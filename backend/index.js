import 'dotenv/config';
import express from 'express';
import mongoose from 'mongoose';
import route from './routes/route.js';
import cors from 'cors';

// Variable Definitions
const app = express();
const port = process.env.PORT;
const mongo_url = process.env.MONGO_DB;

app.use(express.json());

app.use(cors());

// Defining HTTP GET Route
app.get('/', (request, response) => {
    console.log(request);
    return response.status(200).send("Welcome to MERN");
})


app.use('/items', route);

mongoose
  .connect(mongo_url)
  .then(() => {
    console.log('App connected to database');
    app.listen(port, () => {
      console.log(`App is listening to port: ${port}`);
    });
  })
  .catch((error) => {
    console.log(error);
  });