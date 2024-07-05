FROM ubuntu:latest
RUN apt-get install -y openssh-server openssh-client openssl ca-certificates autofs cifs-utils
ENV SSH_PUBKEY_FILEPATH /conf/authorized_keys
ENV SSH_HOSTKEY_FILEPATH /conf/ssh_host_key
ADD entrypoint.sh /
CMD ["bash", "/entrypoint.sh"]
