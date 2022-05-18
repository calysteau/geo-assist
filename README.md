[![geo-assist](https://www.calysteau.fr/images/geo-assist-banner-96.png)](https://calysteau.fr)

# Overview
__geo-assist__ is a Docker based solution to download and prepare geo data.  
  
The basic system contains scripts that allow you to download datasets and convert them (**Shapefiles**, **GeoJSON**, **MBTiles**).

## Building geo-assist
Build the __geo-assist__ image from the Dockerfile.

### Build the docker image
```bash
docker build -t geo-assist .
```

### Use the docker image
```bash
docker run -ti -v $(pwd)/calysteau/dataset:/calysteau/dataset geo-assist
```

## How to use geo-assist
Following samples are based on *Georisques* data from https://www.georisques.gouv.fr/

### Download an archive
```bash
./download.sh https://www.calysteau.fr/data/Georisques2020/georisques_tri_2020.zip fr-tri-2020
```

* Argument 1 : Archive URL
* Argument 2 : Dataset name
* Result : downloaded dataset is available in `/calysteau/fr-tri-2020`

### Convert all datasets shapefiles to GeoJSON files
```bash
./generate_geojsons.sh
```

* No argument
* Result : GeoJSON files are created for all shapefiles in `/calysteau/dataset/` directory

### Convert single dataset shapefiles to GeoJSON files
```bash
./generate_geojsons.sh fr-tri-2020
```

* Argument 1 : Dataset name
* Result : GeoJSON files are created for all shapefiles in in `/calysteau/dataset/fr-tri-2020`

### Create specific layers toponyms in GeoJSON files
*Works only with departements and regions in fr-admin-express dataset.*  
```bash
./generate_geojsons_toponyms.sh
```

* No argument
* Result : GeoJSON files are created for departements and regions in in `/calysteau/dataset/fr-admin-express`

### Convert all datasets GeoJSON files to MBTiles files
```bash
./generate_mbtiles.sh
```

* No argument
* Result : MBTiles files are created for all GeoJSON files in `/calysteau/dataset/` directory

### Convert single dataset Geojson files to MBTiles files
```bash
./generate_mbtiles.sh fr-tri-2020
```

* Argument 1 : Dataset name
* Result : MBTiles files are created all GeoJSON files in `/calysteau/dataset/fr-tri-2020`

----------------------

# Available datasets
* Geoservices IGN admin-express (https://geoservices.ign.fr/adminexpress)
```bash
./download.sh https://www.calysteau.fr/data/Geoservices/admin-express.7z fr-admin-express
```

* Full Metropolitan France TRI 2020 data (https://www.georisques.gouv.fr/)  
*Warning archive size is about 4.6 GB*  
```bash
./download.sh https://files.georisques.fr/di_2020/tri_2020_sig_di.zip fr-tri-2020-full
```

* Géorisques Metropolitan France TRI (TRI zones and municipalities concerned only)
```bash
./download.sh https://www.calysteau.fr/data/Georisques2020/georisques_tri_2020.zip fr-tri-2020
```

* Geoclip polygons French zip codes (https://www.data.gouv.fr/fr/datasets/fond-de-carte-des-codes-postaux/)
```bash
./download.sh https://www.calysteau.fr/data/CodesPostauxFrance/geoclip_codes_postaux_V5.zip fr-zipcode-v5
```

* LaPoste points French zip codes (https://datanova.laposte.fr/explore/dataset/laposte_hexasmal/)
```bash
./download.sh https://www.calysteau.fr/data/CodesPostauxFrance/laposte_hexasmal.zip fr-zipcode-laposte
```

* World Natural Earth (https://www.naturalearthdata.com/)
```bash
./download.sh https://naciscdn.org/naturalearth/packages/natural_earth_vector.zip world-naturalearth
```

* High Seas Master world ports (https://github.com/nvkelso/high-seas)
```bash
./download.sh https://www.calysteau.fr/data/HighSeasMaster/HighSeasMaster.zip world-highseasports
```

* Mile High Club world airports (https://github.com/nvkelso/mile-high-club)
```bash
./download.sh https://www.calysteau.fr/data/MileHighClub/MileHighClub.zip world-airports
```
