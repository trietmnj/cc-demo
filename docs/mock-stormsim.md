# stormsim-mock-plugin

## Setup

1. Seed model data into MinIO:

```bash
./compose init-stormsim
```

2. Build the required container

Start from the directory with both `cc-demo` and `cc-py-sdk`
```bash
docker build -f cc-demo/stormsim-mock-plugin/export.Dockerfile -t cc-stormsim-plugin-test .
```
