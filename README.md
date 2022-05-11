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

## How to use geo-assist

Sample based on Georisques French TRI data optimized from https://www.georisques.gouv.fr/

### Download an archive
```bash
./download.sh https://www.calysteau.fr/data/Georisques2020/georisques_tri_2020.zip tri_2020.zip
```

* Argument 1 : Archive URL
* Argument 2 : Local filename (dataset name will be file basename)
* Result : downloaded dataset is located in /calysteau/tri_2020

### Convert archive shapefiles to Geojson
```bash
./generate_geojsons.sh tri_2020
```

* Argument 1 : Dataset name
* Result : geojson files are in /calysteau/tri_2020

### Convert archive Geojson to MBTiles
```bash
./generate_mbtiles.sh tri_2020
```

* Argument 1 : Dataset name
* Result : mbtiles files are in /calysteau/tri_2020

## Others resources
* Geoclip polygons French zip codes
```bash
./download.sh https://www.calysteau.fr/data/CodesPostauxFrance/geoclip_codes_postaux_V5.zip cp_v5.zip
```

* LaPoste points French zip codes
```bash
./download.sh https://www.calysteau.fr/data/CodesPostauxFrance/laposte_hexasmal.zip cp_laposte.zip
```

* Géorisques Metropolitan France TRI
```bash
./download.sh https://www.calysteau.fr/data/Georisques2020/georisques_tri_2020.zip tri_2020.zip
```

* Geoservices IGN admin-express
```bash
./download.sh https://www.calysteau.fr/data/Geoservices/admin-express.7z admin-express.7z
```

* High Seas Master world ports
```bash
./download.sh https://www.calysteau.fr/data/HighSeasMaster/HighSeasMaster.zip highseasmaster.zip
```

* Mile High Club world airports
```bash
./download.sh https://www.calysteau.fr/data/MileHighClub/MileHighClub.zip milehighclub.zip
```
