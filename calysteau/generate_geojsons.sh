#/!bin/sh
DATASET_NAME=$1

SHAPES=`find dataset/${DATASET_NAME} -name *.shp`
WORKDIR=`pwd`
for SHAPE in $SHAPES; do
  SHAPE_PATH=`dirname "${SHAPE}"`
  SHAPE_BASENAME=`basename "${SHAPE}"`
  JSON_BASENAME=`echo $SHAPE_BASENAME | sed -e 's/.shp/.geojson/g'`
  JSON_BASENAME=`echo "$JSON_BASENAME" | tr '[:upper:]' '[:lower:]'`
  echo "Converting $SHAPE_BASENAME in $JSON_BASENAME"
  cd $SHAPE_PATH
  mapshaper -i $SHAPE_BASENAME -proj wgs84 -o format=geojson precision=0.000001 $JSON_BASENAME
  cd $WORKDIR
done
