#!/usr/bin/env sh
CACERTS="cacert.pem"
TRUSTEDCERTS="TrustedCerts.settings"
START="-----BEGIN CERTIFICATE-----"
END="-----END CERTIFICATE-----"
wget -O ${CACERTS} https://curl.se/ca/cacert.pem 
printf "{TrustedCertificates =  (" > ${TRUSTEDCERTS}
sed -n "/${START}/,/${END}/p" ${CACERTS} | sed "s/${START}/\[/g;s/${END}/\],/g;\$d" >> ${TRUSTEDCERTS}
printf "]);}" >> ${TRUSTEDCERTS}
