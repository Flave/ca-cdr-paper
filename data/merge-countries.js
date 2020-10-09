const fs = require("fs");
const topojsonClient = require("topojson-client");
const topojsonServer = require("topojson-server");
const countryGroups = require("./country-groups");

// const lookup = Object.entries(countryGroups)
//   .filter(([id]) => id !== "World")
//   .reduce((acc, [groupId, group]) => {
//     group.forEach((id) => (acc[id] = groupId));
//     return acc;
//   }, {});

const worldTopo = topojsonServer.topology({
  countries: JSON.parse(fs.readFileSync("./world.geojson", "utf-8")),
});

const geoJson = {
  type: "FeatureCollection",
  features: Object.entries(countryGroups).map(([region, ids]) => {
    const relevantCountries = worldTopo.objects.countries.geometries.filter(
      (country, i) => ids.indexOf(country.properties.ISO_A3) >= 0
    );

    return {
      type: "Feature",
      properties: { region, countries: ids },
      geometry: topojsonClient.merge(worldTopo, relevantCountries),
    };
  }),
};

fs.writeFileSync(
  "./regions.topojson",
  JSON.stringify(topojsonServer.topology({ regions: geoJson }, 1e4))
);
//console.log(merged);
