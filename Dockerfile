ARG BASE
FROM $BASE AS upgraded
RUN apt-get update
RUN apt-get upgrade
FROM upgraded AS builder
RUN apt-get -y install wget
COPY bin/cacerts.sh /cacerts.sh
RUN /cacerts.sh
FROM upgraded
ARG COMMUNIGATE_URL
COPY $COMMUNIGATE_URL /communigate.deb

COPY --from=builder /TrustedCerts.settings /
# RUN dpkg --print-architecture
# RUN apt-get install -y procps
RUN dpkg -i /communigate.deb
#--force-architecture 
RUN rm /communigate.deb
COPY bin/communigate.sh /communigate.sh
ENTRYPOINT ["/communigate.sh"]
