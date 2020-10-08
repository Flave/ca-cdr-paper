#!/bin/bash

shp2json world-shp/ne_10m_admin_0_countries.shp > ./world.geojson
node merge-countries.js
toposimplify -p 0.3 -f < regions.topojson > ../regions.topojson