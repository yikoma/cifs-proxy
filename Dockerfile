FROM alpine:latest
RUN apk --no-cache --update add bash openssh openssl ca-certificates cifs-utils
ENV SSH_PUBKEY_FILEPATH /conf/authorized_keys
ENV SSH_HOSTKEY_FILEPATH /conf/ssh_host_key
ADD entrypoint.sh /
CMD ["bash", "/entrypoint.sh"]
