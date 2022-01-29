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

## ports

```shell
    –	sgr-0dbaf02a76e704843	IPv4	IMAPS	TCP	993	0.0.0.0/0	–
	–	sgr-03753b03d34887893	IPv4	SMTPS	TCP	465	0.0.0.0/0	–
	–	sgr-045c135535e8087dd	IPv6	SMTPS	TCP	465	::/0	–
	–	sgr-0098a683c8bde7566	IPv4	SMTP	TCP	25	0.0.0.0/0	–
	–	sgr-026896d9a6a346de0	IPv6	SMTP	TCP	25	::/0	–
	–	sgr-08ba6d99aad620f60	IPv6	POP3	TCP	110	::/0	–
	–	sgr-0ec74f0e76f01bbb4	IPv4	POP3S	TCP	995	0.0.0.0/0	–
	–	sgr-08c709e6f09f9910a	IPv4	IMAP	TCP	143	0.0.0.0/0	–
	–	sgr-0cbc99ebf5af5d798	IPv6	IMAP	TCP	143	::/0	–
	–	sgr-0ed014b2f4134e44d	IPv6	POP3S	TCP	995	::/0	–
	–	sgr-08011065a08d49f91	IPv4	POP3	TCP	110	0.0.0.0/0	–
	–	sgr-0dc87564f393d1682	IPv6	IMAPS	TCP	993	::/0	–
```
