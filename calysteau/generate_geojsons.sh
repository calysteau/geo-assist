#/!bin/sh
DATASET_NAME=$1

SHAPES=`find dataset/${DATASET_NAME} -name *.shp`
WORKDIR=`pwd`

for SHAPE in $SHAPES; do
  SHAPE_PATH=`dirname "${SHAPE}"`
  SHAPE_BASENAME=`basename "${SHAPE}"`
  JSON_BASENAME=`echo $SHAPE_BASENAME | sed -e 's/.shp/.geojson/g'`
  JSON_BASENAME=`echo "$JSON_BASENAME" | tr '[:upper:]' '[:lower:]'`

  DBF_BASENAME=`echo $SHAPE_BASENAME | sed -e 's/.shp/.dbf/g'`
  SHAPE_FILESIZE=$(stat -c%s "$SHAPE")
  DBF_FILESIZE=$(stat -c%s "$SHAPE_PATH/$DBF_BASENAME")
  TOTAL_SIZE=`expr $SHAPE_FILESIZE + $DBF_FILESIZE`

  if [ "$TOTAL_SIZE" -gt "2147483647" ]; then
    echo "Size of $SHAPE is $TOTAL_SIZE bytes. mapshaper max is 2147483647 bytes"
    echo "Trying to simplify $SHAPE using GDAL"

    cd $SHAPE_PATH

    CONV_BASENAME=`echo $SHAPE_BASENAME | sed -e 's/.shp/_simplified.shp/g'`
    ogr2ogr $CONV_BASENAME $SHAPE_BASENAME -simplify 0.000001

    echo "Converting $CONV_BASENAME in $JSON_BASENAME"
    mapshaper -i $CONV_BASENAME -proj wgs84 -o format=geojson precision=0.000001 $JSON_BASENAME

    rm -fr $(basename $CONV_BASENAME .${CONV_BASENAME##*.}).*

    cd $WORKDIR
  else
    echo "Converting $SHAPE_BASENAME in $JSON_BASENAME"
    cd $SHAPE_PATH
    mapshaper -i $SHAPE_BASENAME -proj wgs84 -o format=geojson precision=0.000001 $JSON_BASENAME
    cd $WORKDIR
  fi
done
