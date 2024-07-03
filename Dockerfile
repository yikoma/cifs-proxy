FROM alpine:latest
RUN apk --no-cache --update add bash openssh openssl ca-certificates autofs cifs-utils samba-client
ENV SSHD_CONFIG_FILEPATH /etc/ssh/sshd_config
ENV SSH_AUTHKEYS_FILEPATH /root/.ssh/authorized_keys
ENV SSH_PUBKEY_FILEPATH /conf/authorized_keys
ADD entrypoint.sh /
CMD ["bash", "/entrypoint.sh"]
