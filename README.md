# Communigate Pro Docker Image

## no architecture/version forced

```shell
docker stop communigate || true && \
docker rm communigate || true && \
export VOLUME=/mnt/data/communigate && \
docker run -d \
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
docker stop communigate || true && \
docker rm communigate || true && \
export VOLUME=/Users/jcolson/communigate && \
docker run -it \
--name communigate \
-p 8010:8010 \
-p 9010:9010 \
-p 8100:8100 \
-p 9100:9100 \
-v ${VOLUME}:/var/CommuniGate \
karmanet/communigate@
```

## amd64 forced version 6.2.14

```shell
docker stop communigate || true && \
docker rm communigate || true && \
export VOLUME=/Users/jcolson/communigate && \
docker run -d \
--name communigate \
-p 25:25 \
-p 8010:8010 \
-p 9010:9010 \
-p 8100:8100 \
-p 9100:9100 \
-v ${VOLUME}:/var/CommuniGate \
karmanet/communigate:6.2.14-amd64
```

docker inspect -f '{{.State.ExitCode}}' communigate
