# Communigate Pro Docker Image

## no architecture/version forced

```shell
docker stop communigate || TRUE && \
docker rm communigate || TRUE && \
export VOLUME=/Users/jcolson/communigate && \
docker run -it \
--name communigate \
-p 8010:8010 \
-p 9010:9010 \
-p 8100:8100 \
-p 9100:9100 \
-v ${VOLUME}:/var/CommuniGate \
karmanet/communigate
```

## armv7 forced version 6.2.14

for some reason the html is not getting displayed when attaching to port 8010 for initial setup on arm

```shell
docker stop communigate || TRUE && \
docker rm communigate || TRUE && \
export VOLUME=/Users/jcolson/communigate && \
docker run -it \
--name communigate \
-p 8010:8010 \
-p 9010:9010 \
-p 8100:8100 \
-p 9100:9100 \
-v ${VOLUME}:/var/CommuniGate \
karmanet/communigate@sha256:2ea57feb7bd7e851d693e4b96cecc0780a33b191a8e4ff2c07d3e5714f571e9f
```

## amd64 forced version 6.2.14

```shell
docker stop communigate || TRUE && \
docker rm communigate || TRUE && \
export VOLUME=/Users/jcolson/communigate && \
docker run -it \
--name communigate \
-p 8010:8010 \
-p 9010:9010 \
-p 8100:8100 \
-p 9100:9100 \
-v ${VOLUME}:/var/CommuniGate \
karmanet/communigate@sha256:76e8c4ad9af6f10c6b500e316b6ab4bfd47c0486394a916c75ec224662252443
```
