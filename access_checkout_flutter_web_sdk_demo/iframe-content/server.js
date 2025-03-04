const express = require('express');

const host = 'localhost';
const port = 3000;
const app = express();
app.set('port', port);

app.use(express.static(__dirname));

app.listen(port, host, () => console.info(`Server started and running on port ${port}`));
