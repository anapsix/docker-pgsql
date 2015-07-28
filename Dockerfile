FROM alpine:3.2
RUN apk upgrade --update && \
    apk add postgresql && \
    touch /run/openrc/softlevel && \
    /etc/init.d/postgresql setup && \
    rm /run/openrc/softlevel
COPY ./gosu-amd64 /usr/local/bin/gosu
EXPOSE 5432
CMD gosu postgres /usr/bin/postgres --config-file=/var/lib/postgresql/9.4/data/postgresql.conf -D /var/lib/postgresql/9.4/data
