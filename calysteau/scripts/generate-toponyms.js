import fs from 'fs'
import path from 'path'
import _ from 'lodash'
import JSONStream from 'JSONStream'
import centroid from '@turf/centroid'
import bbox from '@turf/bbox'
import bboxPolygon from '@turf/bbox-polygon'

function generate_toponyms(file) {
  let content = fs.readFileSync(file)
  let stream = JSONStream.parse('features.*')
  let toponymCollection = {
    type: 'FeatureCollection',
    features: []
  }
  stream.on('data', function(feature) {
    let toponym = centroid(bboxPolygon(bbox(feature)))
    toponym.properties = feature.properties
    toponymCollection.features.push(toponym)
  })
  stream.on('end', function() {
    const toponymFile = path.join(path.dirname(file), path.basename(file, path.extname(file)) + '_toponyms.geojson')
    fs.writeFileSync(toponymFile, JSON.stringify(toponymCollection))  
  })
  stream.write(content)
  stream.end()
}

generate_toponyms(process.argv[2])
