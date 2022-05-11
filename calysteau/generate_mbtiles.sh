#/!bin/sh
ARCHIVE_NAME=$1

GEOJSONS=`find dataset/${ARCHIVE_NAME} -name '*.geojson'`
WORKDIR=`pwd`
for GEOJSON in $GEOJSONS; do
  echo "Processing file $GEOJSON"
  GEOJSON_PATH=`dirname "${GEOJSON}"`
  GEOJSON_BASENAME=`basename "${GEOJSON}"`
  MBTILES_BASENAME=`echo $GEOJSON_BASENAME | sed -e 's/.geojson/.mbtiles/g'`
  cd $GEOJSON_PATH
  tippecanoe -f -o $MBTILES_BASENAME -Z8 -z12 --coalesce-densest-as-needed --extend-zooms-if-still-dropping --drop-smallest-as-needed $GEOJSON_BASENAME
  cd $WORKDIR
done
