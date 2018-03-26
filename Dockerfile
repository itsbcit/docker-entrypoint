FROM alpine:latest

ADD docker-entrypoint.sh /docker-entrypoint.sh
ADD docker-entrypoint.d /docker-entrypoint.d
RUN chmod 555 /docker-entrypoint.sh \
 && chmod 664 /etc/passwd /etc/group

ENTRYPOINT [ "/docker-entrypoint.sh" ]
