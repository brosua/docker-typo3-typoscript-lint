# Docker image for `TypoScript Lint`

[![Docker hub](http://dockeri.co/image/brosua/typo3-typoscript-lint?&kill_cache=1)](https://hub.docker.com/r/brosua/typo3-typoscript-lint)

Tiny Alpine-based multistage-build dockerized version of [TypoScript Lint](https://github.com/martin-helmich/typo3-typoscript-lint). The image is built with the latest PHP and Typoscript Lint version.

## Usage
### Command line
```bash
docker run --rm -it -v $(pwd):/data brosua/typo3-typoscript-lint .
```
You can also add all options of typo3-typoscript-lint to your command:
```bash
docker run --rm -it -v $(pwd):/data brosua/typo3-typoscript-lint -c .build/testing/.typoscript-lint.yml
```
### GitLab CI
```yaml
stages:
 - lint

lint-typoscript:
  stage: lint
  image:
    name: brosua/typo3-typoscript-lint
    entrypoint: ["/bin/ash", "-c"]
  script:
    - typoscript-lint
```

## License

**[MIT License](LICENSE)**