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

CMD ["/bin/bash"]
