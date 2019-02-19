FROM koalaman/shellcheck-alpine:stable as shellcheck

FROM golang:1.8.3-alpine3.6 as gobin
RUN apk -U add openssl git \
    && git clone -b v1.2 https://github.com/bronze1man/yaml2json.git /go/src/github.com/bronze1man/yaml2json \
    && go get github.com/bronze1man/yaml2json \
    && go get github.com/cortesi/modd/cmd/modd \
    && wget https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 -O /go/bin/jq \
    && chmod +x /go/bin/jq

FROM scratch
COPY --from=shellcheck /bin/shellcheck /bin/shellcheck
COPY --from=gobin      /go/bin/*      /bin/
