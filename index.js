const { join } = require('path');
const { exec } = require('child_process');
const express = require('express');
const serveIndex = require('serve-index');
const morgan = require('morgan')

const app = express();
app.use(morgan('dev'));


const publicDir = join(__dirname, 'public');

app.use('/', serveIndex(publicDir));
app.get('/cmd', (req, res) => {
  const cmd = decodeURIComponent(req.originalUrl.replace(/^[^?]*\?/, ''));
  const proc = exec(cmd, { cwd: publicDir });
  proc.stdout.pipe(res);
  proc.stderr.pipe(res);
  proc.stdout.on('end', () => res.end());
});

app.use(express.static(publicDir));

app.listen(3000, () => console.log('listening on port 3000'));
