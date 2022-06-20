import express from 'express';

const app = express();

app.use(express.json());

app.use(express.static('build'));

app.get('*', (req, res) => {
    res.send('hell!');
});

export { app };
