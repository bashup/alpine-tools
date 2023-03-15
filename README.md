## Miscellaneous Tool Builds

This docker image provides alpine binaries (in `/bin`) for various tools that are not available as alpine APKs.  Its purpose is to be a source image for other alpine-based images (e.g. [dirtsimple/php-server](https://github.com/dirtsimple/php-server) and [bashup/bash-kit](https://github.com/bashup/bash-kit)) to copy tools from.

Currently, the tools built include:

* [shellcheck](https://github.com/koalaman/shellcheck)
* [yaml2json](https://github.com/bronze1man/yaml2json)
* [modd](https://github.com/cortesi/modd) (v0.8, patched to use a 300ms debounce rate)
* [jq 1.6](https://stedolan.github.io/jq/)
* [adnanh/webhook](https://github.com/adnanh/webhook) 2.8.0

To use them in a docker image build, you can do something like this:

```dockerfile
FROM ghcr.io/bashup/alpine-tools:latest as alpine-tools

FROM whatever/thing   # whatever your actual base image is
COPY --from=alpine-tools /bin/* /usr/bin/
```

(Or of course you can copy individual binaries rather than all of them.)