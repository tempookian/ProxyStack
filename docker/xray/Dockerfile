FROM alpine:latest

WORKDIR /root
COPY xray.sh /root/xray.sh
RUN set -ex \
	&& apk add --no-cache tzdata ca-certificates \
	&& mkdir -p /var/log/xray /usr/share/xray \
	&& chmod +x /root/xray.sh \
	&& /root/xray.sh \
	&& rm -fv /root/xray.sh \
	&& wget -O /usr/share/xray/geosite.dat https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat \
	&& wget -O /usr/share/xray/geoip.dat https://github.com/v2fly/geoip/releases/latest/download/geoip.dat

