FROM golang:1.12-alpine3.9 as gobin
COPY --from=jwilder/dockerize:0.6.0 /usr/local/bin/dockerize /go/bin/
COPY --from=koalaman/shellcheck-alpine:stable /bin/shellcheck /go/bin/

RUN apk -U add openssl git
RUN wget https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 -O /go/bin/jq
COPY ./gobuild /
RUN chmod +x /go/bin/jq /gobuild \
    && /gobuild adnanh/webhook 2.6.11 \
    && /gobuild bronze1man/yaml2json v1.2 \
    && GO11MODULE=on /gobuild bashup/modd forthelullz cortesi/modd cmd/modd && ls -l /go/bin

FROM scratch
COPY --from=gobin      /go/bin/*      /bin/
