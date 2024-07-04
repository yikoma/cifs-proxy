FROM alpine:latest
RUN apk --no-cache --update add bash openssh openssl ca-certificates autofs cifs-utils openrc
ENV SSH_PUBKEY_FILEPATH /conf/authorized_keys
ENV SSH_HOSTKEY_FILEPATH /conf/ssh_host_key
RUN mkdir /etc/autofs/auto.master.d
ADD entrypoint.sh /
CMD ["bash", "/entrypoint.sh"]
