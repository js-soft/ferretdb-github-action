# FerretDB GitHub Action

## Introduction

This GitHub Action starts a FerretDB instance and a connected PostgreSQL database. You can configure a custom port using the `ferretdb-port` input, by default it is the default MongoDB port `27017`.

The FerretDB version can be specified using the `ferretdb-version` input. The default version is `latest`. You can find all available FerretDB versions on [GitHub](https://github.com/FerretDB/FerretDB/releases).

## Usage

```yaml
name: Run tests

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Git checkout
        uses: actions/checkout@v3

      - name: Use Node.js
        uses: actions/setup-node@v3
        with:
          node-version: 18

      - name: Start FerretDB
        uses: js-soft/ferretdb-github-action@1.0.0
        with:
          ferretdb-version: 0.8.1

      - run: npm install
      - run: npm test
```

## License

[MIT](LICENSE)
