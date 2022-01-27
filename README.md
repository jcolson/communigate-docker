# Communigate Pro Docker Image

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
