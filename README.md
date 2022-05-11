![geo-assist](https://www.calysteau.fr/images/calysteau-banner-96.png)

# geo-assist
A Docker based solution to download and prepare Calysteau Geo data. geo-assist contains scripts that allow to download dataset and convert it to individual **geojson** files or to a global **mbtiles**.

### Build the docker image
```bash
docker build -t geo-assist .
```

### Use the docker image
```bash
docker run -ti -v $(pwd)/calysteau:/geo-assist/calysteau geo-assist
```

### Download an archive
```bash
./download-archive.sh https://www.calysteau.fr/data/Georisques2020/georisques_tri_2020.zip tri_2020.zip
```

* Argument 1 : Archive URL
* Argument 2 : Archive full filename

Sample based on Georisques TRI data optimized from https://www.georisques.gouv.fr/

### Convert archive shapefiles to Geojson
```bash
./generate_geojsons.sh tri_2020
```

* Argument 1 : Archive dataset name

### Convert archive Geojson to MBTiles
```bash
./generate_mbtiles.sh tri_2020
```

* Argument 1 : Archive dataset name
