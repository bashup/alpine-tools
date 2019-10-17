FROM koalaman/shellcheck-alpine:stable as shellcheck

FROM golang:1.9-alpine3.6 as gobin
RUN apk -U add openssl git \
    && build() { \
        cd /go/src && \
        git clone -q ${2+-b "$2"} --depth=1 https://github.com/"$1" github.com/"${3-$1}" && \
        go get github.com/"${3-$1}${4+/$4}"; \
    } \
    && build bronze1man/yaml2json v1.2 \
    && build bashup/modd forthelullz cortesi/modd cmd/modd \
    && wget https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 -O /go/bin/jq \
    && chmod +x /go/bin/jq

FROM scratch
COPY --from=shellcheck /bin/shellcheck /bin/shellcheck
COPY --from=gobin      /go/bin/*      /bin/
