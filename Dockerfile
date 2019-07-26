FROM alpine:latest
MAINTAINER avpnusr

EXPOSE 8118 9050

RUN apk --update --no-cache add privoxy tor runit tini wget --repository http://dl-3.alpinelinux.org/alpine/edge/testing/

COPY service /etc/service/

HEALTHCHECK --interval=180s --timeout=15s --start-period=120s --retries=3 \
            CMD wget --no-check-certificate -e use_proxy=yes -e http_proxy=127.0.0.1:8118 --quiet --spider 'https://3g2upl4pq6kufc4m.onion' || exit 1

ENTRYPOINT ["tini", "--"]
CMD ["runsvdir", "/etc/service"]
