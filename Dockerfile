
FROM golang:1.12-alpine3.9 as gobin
COPY --from=jwilder/dockerize:0.6.0 /usr/local/bin/dockerize /go/bin/
COPY --from=koalaman/shellcheck-alpine:stable /bin/shellcheck /go/bin/

RUN apk -U add openssl git
RUN wget https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 -O /go/bin/jq
RUN chmod +x /go/bin/jq
RUN build() { \
        cd /go/src && \
        git -c advice.detachedHead=false \
            clone -q ${2+-b "$2"} --depth=1 https://github.com/"$1" github.com/"${3-$1}" && \
        go get -ldflags="-s -w" github.com/"${3-$1}${4+/$4}"; \
    } \
    && build adnanh/webhook 2.6.11 \
    && build bronze1man/yaml2json v1.2 \
    && build bashup/modd forthelullz cortesi/modd cmd/modd

FROM scratch
COPY --from=gobin      /go/bin/*      /bin/
