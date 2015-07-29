FROM alpine:3.2
RUN apk upgrade --update && \
    apk add postgresql && \
    touch /run/openrc/softlevel && \
    /etc/init.d/postgresql setup && \
    rm /run/openrc/softlevel && \
    cp /var/lib/postgresql/9.4/data/postgresql.conf /etc/postgresql.conf && \
    chmod 644 /etc/postgresql.conf
COPY ./gosu-amd64 /usr/local/bin/gosu
COPY docker-entrypoint.sh /entrypoint.sh
VOLUME /var/lib/postgresql
EXPOSE 5432
ENTRYPOINT ["/entrypoint.sh"]
CMD ["postgres"]
