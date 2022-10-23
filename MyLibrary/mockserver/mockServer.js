const express = require('express');
const app = express();

app.get('/data/2.5/weather', (request, response) => {
  response.json(
    {"coord":{"lon":-123.262,"lat":44.5646},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"base":"stations","main":{"temp":294.72,"feels_like":294.5,"temp_min":293.36,"temp_max":296.88,"pressure":1014,"humidity":60},"visibility":10000,"wind":{"speed":3.13,"deg":22,"gust":5.81},"clouds":{"all":0},"dt":1664648917,"sys":{"type":2,"id":2005452,"country":"US","sunrise":1664633455,"sunset":1664675654},"timezone":-25200,"id":5720727,"name":"Corvallis","cod":200}
  );
});





app.listen(3000, () => {
    console.log("Listen to port 3000")
});

