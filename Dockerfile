ARG BASE
FROM $BASE AS builder
ARG COMMUNIGATE_URL
RUN apt-get update
RUN apt-get upgrade
RUN apt-get -y install wget
RUN wget -O /communigate.deb $COMMUNIGATE_URL
FROM $BASE
COPY --from=builder /communigate.deb /
#--force-architecture 
# RUN dpkg --print-architecture
RUN if [ `dpkg --print-architecture` = 'arm64' ]; then dpkg --add-architecture armhf && apt-get update && apt-get install -y libc6:armhf libcrypt1:armhf; fi
# RUN apt-get install -y procps
RUN dpkg -i /communigate.deb
RUN rm /communigate.deb
COPY bin/communigate.sh /communigate.sh
ENTRYPOINT ["/communigate.sh"]
