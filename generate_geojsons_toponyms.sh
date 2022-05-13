#/!bin/sh
DATASET_NAME=$1

GEOJSONS=`find dataset/${DATASET_NAME} -name '*.geojson'`

for GEOJSON in $GEOJSONS; do

  GEOJSON_PATH=`dirname "${GEOJSON}"`
  GEOJSON_BASENAME=`basename "${GEOJSON}"`
  DATASET_NAME=`echo $GEOJSON_PATH | cut -d '/' -f 2`

  if [ $DATASET_NAME = "fr-admin-express" ]; then
    if [ $GEOJSON_BASENAME = "region.geojson" ] || [ $GEOJSON_BASENAME = "departement.geojson" ]; then
      echo "Processing file $GEOJSON_BASENAME in $DATASET_NAME"
      node scripts/generate-toponyms "$GEOJSON"
    fi
  fi
done
