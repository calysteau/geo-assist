# geo-assist
A Docker based solution to download and prepare Calysteau Geo data
geo-assist contains scripts that allow to download dataset and convert it to individual **geojson** files or to a global **mbtiles**.

# Build the docker image
docker build -t geo-assist .

# Use the docker image
docker run -ti -v $(pwd)/calysteau:/geo-assist/calysteau geo-assist
