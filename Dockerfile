FROM node:18.1.0-bullseye-slim
LABEL maintainer "<contact@calysteau.fr>"

# Install utilities
RUN apt-get update \
    && apt-get install -y wget curl openssl ca-certificates nano unzip p7zip-full libsqlite3-dev zlib1g-dev git build-essential gdal-bin --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Install mapshaper
RUN npm install -g mapshaper

# Install rclone
RUN curl -k -O https://downloads.rclone.org/rclone-current-linux-amd64.zip \
    && unzip rclone-current-linux-amd64.zip \
    && cd rclone-*-linux-amd64 && cp rclone /usr/bin/ && cd .. \
    && chmod 755 /usr/bin/rclone 

# Install tippcanoe
RUN git clone https://github.com/mapbox/tippecanoe \
  && cd tippecanoe \
  && make -j  \
  && make install

# Setup workdir
WORKDIR /calysteau

# Install sources and scripts
COPY calysteau/script/generate-toponyms.js script/generate-toponyms.js
COPY calysteau/download.sh download.sh
COPY calysteau/generate_geojsons.sh generate_geojsons.sh
COPY calysteau/generate_geojsons_toponyms.sh generate_geojsons_toponyms.sh
COPY calysteau/generate_mbtiles.sh generate_mbtiles.sh
RUN chmod +x download.sh generate_geojsons.sh generate_geojsons_toponyms.sh generate_mbtiles.sh

COPY calysteau/package.json package.jsons
COPY calysteau/yarn.lock yarn.lock
RUN yarn

CMD ["/bin/bash"]
