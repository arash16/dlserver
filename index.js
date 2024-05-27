const { join } = require('path');
const { exec } = require('child_process');
const express = require('express');
const serveIndex = require('serve-index');

const app = express();
const publicDir = join(__dirname, 'public');

app.use('/', serveIndex(publicDir));
app.get('/dl', (req, res) => {
  const url = req.originalUrl.replace(/^[^?]*\?/, '');
  const proc = exec('aria2c ' + url, { cwd: publicDir });
  proc.stdout.pipe(res);
  proc.stderr.pipe(res);
  proc.stdout.on('end', () => res.end());
});

app.get('/yt', (req, res) => {
  const url = req.originalUrl.replace(/^[^?]*\?/, '');
  const proc = exec('youtube-dl ' + url, { cwd: publicDir });
  proc.stdout.pipe(res);
  proc.stderr.pipe(res);
  proc.stdout.on('end', () => res.end());
});

app.use(express.static(publicDir));

app.listen(3000, () => {
  console.log('listening');
});
