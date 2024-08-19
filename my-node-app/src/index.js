const http = require('http');

const port = process.env.PORT || 3000; // Usa el puerto de Azure o un puerto local para desarrollo

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('Me siento el doble de Feliz!\n');
});

server.listen(port, '0.0.0.0', () => {
  console.log(`Server running at http://0.0.0.0:${port}/`);
});

