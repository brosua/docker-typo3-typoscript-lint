ARG PHP
FROM php:cli as builder

# Install build dependencies
RUN set -eux \
	&& DEBIAN_FRONTEND=noninteractive apt-get update -qq \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -qq -y --no-install-recommends --no-install-suggests \
		ca-certificates \
		curl \
		git

ARG PCF
RUN set -eux 
RUN curl -s https://api.github.com/repos/martin-helmich/typo3-typoscript-lint/releases/latest \
    | grep browser_download_url \
    | grep 'typoscript-lint-*.*.*.phar' \
    | head -n 1 \
    | cut -d '"' -f 4 \
    | xargs curl -sS -L -o /typoscript-lint
RUN chmod +x /typoscript-lint
RUN mv /typoscript-lint /usr/bin/typoscript-lint


ARG PHP
FROM php:cli-alpine as production
LABEL \
	maintainer="Josua Vogel" \
	repo="https://github.com/brosua/docker-typo3-typoscript-lint"

COPY --from=builder /usr/bin/typoscript-lint /usr/bin/typoscript-lint
ENV WORKDIR /data
WORKDIR /data

ENTRYPOINT ["typoscript-lint"]