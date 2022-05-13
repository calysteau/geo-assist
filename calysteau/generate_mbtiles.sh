#/!bin/sh
DATASET_NAME=$1

GEOJSONS=`find dataset/${DATASET_NAME} -name '*.geojson'`
WORKDIR=`pwd`

for GEOJSON in $GEOJSONS; do

  GEOJSON_PATH=`dirname "${GEOJSON}"`
  GEOJSON_BASENAME=`basename "${GEOJSON}"`
  MBTILES_BASENAME=`echo $GEOJSON_BASENAME | sed -e 's/.geojson/.mbtiles/g'`
  DATASET_NAME=`echo $GEOJSON_PATH | cut -d '/' -f 2`

  echo "Processing file $GEOJSON_BASENAME in $DATASET_NAME"
  cd $GEOJSON_PATH

  if [ $DATASET_NAME = "fr-admin-express" ]; then
    echo "Processing IGN admin-express"
    if [ $GEOJSON_BASENAME = "commune.geojson" ] || [ $GEOJSON_BASENAME = "commune_associee_ou_deleguee.geojson" ] || [ $GEOJSON_BASENAME = "arrondissement_municipal.geojson" ]; then
      echo "Applying french commune parameters"
      tippecanoe -f -o $MBTILES_BASENAME -Z8 -z12 --coalesce-densest-as-needed --extend-zooms-if-still-dropping --drop-smallest-as-needed $GEOJSON_BASENAME
    elif [ $GEOJSON_BASENAME = "chflieu_commune.geojson" ] || [ $GEOJSON_BASENAME = "chflieu_arrondissement_municipal.geojson" ] || [ $GEOJSON_BASENAME = "chflieu_commune_associee_ou_deleguee.geojson" ]; then
      echo "Applying french chef lieu parameters"
      tippecanoe -f -o $MBTILES_BASENAME -Z8 -z12 --coalesce-densest-as-needed -r1 --cluster-distance=10 $GEOJSON_BASENAME
    elif [ $GEOJSON_BASENAME = "collectivite_territoriale.geojson" ] || [ $GEOJSON_BASENAME = "canton.geojson" ] || [ $GEOJSON_BASENAME = "arrondissement.geojson" ] || [ $GEOJSON_BASENAME = "epci.geojson" ]; then
      echo "Applying french canton parameters"
      tippecanoe -f -o $MBTILES_BASENAME -Z6 -z12 --coalesce-densest-as-needed --extend-zooms-if-still-dropping --drop-smallest-as-needed --simplification=10 $GEOJSON_BASENAME
    elif [ $GEOJSON_BASENAME = "departement_toponyme.geojson" ]; then
      echo "Applying french departement toponyme parameters"
      tippecanoe -f -o $MBTILES_BASENAME -Z4 -z12 --coalesce-densest-as-needed -r1 --cluster-distance=10 $GEOJSON_BASENAME
    elif [ $GEOJSON_BASENAME = "departement.geojson" ]; then
      echo "Applying french departement parameters"
      tippecanoe -f -o $MBTILES_BASENAME -Z4 -z12 --coalesce-densest-as-needed --extend-zooms-if-still-dropping --drop-smallest-as-needed --simplification=10 --simplify-only-low-zooms $GEOJSON_BASENAME
    elif [ $GEOJSON_BASENAME = "region_toponyme.geojson" ]; then
      echo "Applying french region toponymes parameters"
      tippecanoe -f -o $MBTILES_BASENAME -Z2 -z12 --coalesce-densest-as-needed -r1 --cluster-distance=10 $GEOJSON_BASENAME
    else
      echo "Applying IGN admin-express default parameters"
      tippecanoe -f -o $MBTILES_BASENAME -Z2 -z12 --coalesce-densest-as-needed --extend-zooms-if-still-dropping --drop-smallest-as-needed --simplification=12 --simplify-only-low-zooms $GEOJSON_BASENAME
    fi
  elif [ $DATASET_NAME = "fr-zipcode-laposte" ] || [ $DATASET_NAME = "world-airports" ] || [ $DATASET_NAME = "world-highseasports" ]; then
    echo "Applying Calysteau global points parameters"
    tippecanoe -f -o $MBTILES_BASENAME -Z8 -z12 --coalesce-densest-as-needed -r1 --cluster-distance=10 $GEOJSON_BASENAME
  elif [ $DATASET_NAME = "world-naturalearth" ]; then
    echo "Applying Natural Earth parameters"
    tippecanoe -zg -o $MBTILES_BASENAME --coalesce-densest-as-needed --extend-zooms-if-still-dropping $GEOJSON_BASENAME
  else
    echo "Applying default parameters"
    tippecanoe -f -o $MBTILES_BASENAME -Z2 -z12 --coalesce-densest-as-needed --extend-zooms-if-still-dropping --drop-smallest-as-needed --simplification=12 --simplify-only-low-zooms $GEOJSON_BASENAME
  fi

  cd $WORKDIR

done
