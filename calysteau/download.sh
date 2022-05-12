#/!bin/sh
ARCHIVE_URL=$1
DATASET_NAME=$2
ARCHIVE_FILEEXT="${ARCHIVE_URL##*.}"
ARCHIVE_FILENAME="${DATASET_NAME}.${ARCHIVE_FILEEXT}"

echo "Processing $DATASET_NAME"
mkdir -p dataset

echo "Downloading $ARCHIVE_URL"
wget $ARCHIVE_URL -O dataset/$ARCHIVE_FILENAME

echo "Uncompressing $ARCHIVE_FILENAME"
rm -fr dataset/$DATASET_NAME
7z x dataset/$ARCHIVE_FILENAME -odataset/$DATASET_NAME
rm -fr dataset/$ARCHIVE_FILENAME
