FROM alpine:latest
RUN apk --no-cache --update add bash openssh-client openssh-server autofs cifs-utils samba-client
ADD entrypoint.sh /
CMD ["bash", "/entrypoint.sh"]
