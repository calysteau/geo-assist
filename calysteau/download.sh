#/!bin/sh
ARCHIVE_URL=$1
ARCHIVE_NAME=$2
ARCHIVE_FILEEXT="${ARCHIVE_NAME##*.}"
ARCHIVE_FILENAME="${ARCHIVE_NAME%.*}"

echo "Processing $ARCHIVE_NAME"
mkdir -p dataset

echo "Downloading $ARCHIVE_URL"
wget $ARCHIVE_URL -O dataset/$ARCHIVE_NAME

echo "Uncompressing $ARCHIVE_NAME"
rm -fr dataset/$ARCHIVE_FILENAME
7z x dataset/$ARCHIVE_NAME -odataset/$ARCHIVE_FILENAME
rm -fr dataset/$ARCHIVE_NAME
