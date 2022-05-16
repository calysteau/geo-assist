#/!bin/sh
DATASET_NAME=$1

MBTILES=`find dataset/${DATASET_NAME} -name '*.mbtiles'`

echo "Merging $DATASET_NAME mbtiles"
tile-join -f -o dataset/$DATASET_NAME.mbtiles $MBTILES
