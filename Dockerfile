FROM lsiobase/alpine:3.10

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="webflo version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="chbmb"
# hard set UTC in case the user does not define it
ENV TZ="Etc/UTC"

RUN \
	echo "**** install build packages ****" && \
	apk add --no-cache --virtual=build-dependencies	g++ gcc	libxml2-dev	libxslt-dev  py2-pip  python2-dev && \
	echo "**** install packages ****" && \
	apk add --no-cache curl ffmpeg libxml2 libxslt python2 unrar unzip && \
	echo "**** install bazarr ****" && \
	mkdir -p /app/bazarr

COPY ./bazarr /app/bazarr

RUN \
	rm -Rf /app/bazarr/data && \
	rm -Rf /app/bazarr/bin && \
	echo "**** Install requirements ****" && \
	pip install --no-cache-dir -U  -r /app/bazarr/requirements.txt && \ 
	echo "**** clean up ****" && \
	apk del --purge build-dependencies && \
	rm -rf 	/root/.cache /tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 6767
VOLUME /config /movies /tv
