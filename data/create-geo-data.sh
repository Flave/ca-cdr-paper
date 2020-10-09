#!/bin/bash

shp2json world-shp/ne_10m_admin_0_countries.shp > ./world.geojson
geo2topo countries=world.geojson > world.topojson
toposimplify -p 0.1 -f < world.topojson | topoquantize 1e4 > ./world-simplified.topojson

#node merge-countries.js
#toposimplify -p 0.3 -f < regions.topojson > ../regions.topojson


topomerge -k '
  {"USA":"USA","PRI":"USA","ABW":"LAM","AIA":"LAM","ARG":"LAM","ATG":"LAM","BES":"LAM","BHS":"LAM","BLM":"LAM","BLZ":"LAM","BMU":"LAM","BOL":"LAM","BRA":"LAM","BRB":"LAM","CHL":"LAM","COL":"LAM","CRI":"LAM","CUB":"LAM","CUW":"LAM","CYM":"LAM","DMA":"LAM","DOM":"LAM","ECU":"LAM","FLK":"LAM","GLP":"LAM","GRD":"LAM","GTM":"LAM","GUF":"LAM","GUY":"LAM","HND":"LAM","HTI":"LAM","JAM":"LAM","KNA":"LAM","LCA":"LAM","MEX":"LAM","MSR":"LAM","MTQ":"LAM","NIC":"LAM","PAN":"LAM","PER":"LAM","PRY":"LAM","SLV":"LAM","SUR":"LAM","SXM":"LAM","TCA":"LAM","TTO":"LAM","URY":"LAM","VCT":"LAM","VEN":"LAM","VGB":"LAM","VIR":"LAM","ALA":"EUR","AUT":"EUR","BEL":"EUR","BGR":"EUR","CYP":"EUR","CZE":"EUR","DEU":"EUR","DNK":"EUR","ESP":"EUR","EST":"EUR","FIN":"EUR","FRA":"EUR","FRO":"EUR","GBR":"EUR","GIB":"EUR","GRC":"EUR","GRL":"EUR","HUN":"EUR","IMN":"EUR","IRL":"EUR","ITA":"EUR","JEY":"EUR","LTU":"EUR","LUX":"EUR","LVA":"EUR","MLT":"EUR","NLD":"EUR","POL":"EUR","PRT":"EUR","ROU":"EUR","SVK":"EUR","SVN":"EUR","SWE":"EUR","AGO":"AFR","BDI":"AFR","BEN":"AFR","BFA":"AFR","BWA":"AFR","CAF":"AFR","CIV":"AFR","CMR":"AFR","COD":"AFR","COG":"AFR","COM":"AFR","CPV":"AFR","DJI":"AFR","ERI":"AFR","ETH":"AFR","GAB":"AFR","GHA":"AFR","GIN":"AFR","GMB":"AFR","GNB":"AFR","GNQ":"AFR","KEN":"AFR","LBR":"AFR","LSO":"AFR","MDG":"AFR","MLI":"AFR","MOZ":"AFR","MRT":"AFR","MUS":"AFR","MWI":"AFR","MYT":"AFR","NAM":"AFR","NER":"AFR","NGA":"AFR","REU":"AFR","RWA":"AFR","SDN":"AFR","SEN":"AFR","SHN":"AFR","SLE":"AFR","SOM":"AFR","SSD":"AFR","STP":"AFR","SWZ":"AFR","SYC":"AFR","TCD":"AFR","TGO":"AFR","TZA":"AFR","UGA":"AFR","ZMB":"AFR","ZWE":"AFR","ARE":"MEA","ARM":"MEA","AZE":"MEA","BHR":"MEA","DZA":"MEA","EGY":"MEA","ESH":"MEA","GEO":"MEA","IRN":"MEA","IRQ":"MEA","ISR":"MEA","JOR":"MEA","KAZ":"MEA","KGZ":"MEA","KWT":"MEA","LBN":"MEA","LBY":"MEA","MAR":"MEA","OMN":"MEA","PSE":"MEA","QAT":"MEA","SAU":"MEA","SYR":"MEA","TJK":"MEA","TKM":"MEA","TUN":"MEA","UZB":"MEA","YEM":"MEA","IND":"IND","RUS":"RUS","CHN":"CHN","HKG":"CHN","MAC":"CHN"}[d.properties.ISO_A3] || "rest"
' regions=countries < world-simplified.topojson > world-merged.topojson

a.indexOf(d.properties.ISO_A3)