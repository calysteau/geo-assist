[![geo-assist](https://www.calysteau.fr/images/calysteau-banner-96.png)](https://calysteau.fr)

# geo-assist
A Docker based solution to download and prepare geo data. geo-assist contains scripts that allow to download dataset and convert it (**shapefiles**, **geojson**, **mbtiles**).

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
./download.sh https://www.calysteau.fr/data/Georisques2020/georisques_tri_2020.zip fr-tri-2020
```

* Argument 1 : Archive URL
* Argument 2 : Dataset name
* Result : downloaded dataset is available in /calysteau/fr-tri-2020

### Convert dataset shapefiles to Geojson
```bash
./generate_geojsons.sh fr-tri-2020
```

* Argument 1 : Dataset name
* Result : geojson files are created in /calysteau/fr-tri-2020

### Convert dataset Geojson to MBTiles
```bash
./generate_mbtiles.sh fr-tri-2020
```

* Argument 1 : Dataset name
* Result : mbtiles files are created in /calysteau/fr-tri-2020

## Others resources
* Geoservices IGN admin-express
```bash
./download.sh https://www.calysteau.fr/data/Geoservices/admin-express.7z fr-admin-express
```

* Géorisques Metropolitan France TRI (TRI zones and municipalities concerned only)
```bash
./download.sh https://www.calysteau.fr/data/Georisques2020/georisques_tri_2020.zip fr-tri-2020
```

* Full Metropolitan France TRI 2020 data from Géorisques website (warning size 4.6 GO)
```bash
./download.sh https://files.georisques.fr/di_2020/tri_2020_sig_di.zip fr-tri-2020-full
```

* Geoclip polygons French zip codes
```bash
./download.sh https://www.calysteau.fr/data/CodesPostauxFrance/geoclip_codes_postaux_V5.zip fr-zipcode-v5
```

* LaPoste points French zip codes
```bash
./download.sh https://www.calysteau.fr/data/CodesPostauxFrance/laposte_hexasmal.zip fr-zipcode-laposte
```

* High Seas Master world ports
```bash
./download.sh https://www.calysteau.fr/data/HighSeasMaster/HighSeasMaster.zip world-highseasports
```

* Mile High Club world airports
```bash
./download.sh https://www.calysteau.fr/data/MileHighClub/MileHighClub.zip world-airports
```
