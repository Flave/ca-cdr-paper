#!/bin/bash

shp2json world-shp/ne_10m_admin_0_countries.shp > ./world.geojson
geo2topo countries=world.geojson > world.topojson
toposimplify -p 0.1 -f < world.topojson | topoquantize 1e4 > ./world-simplified.topojson

#node merge-countries.js
#toposimplify -p 0.3 -f < regions.topojson > ../regions.topojson