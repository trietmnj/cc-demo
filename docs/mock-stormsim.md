# StormSim Mock Plugin

## Setup

### 1. Start Up the Infrastructure
```bash
./compose infras-up
```

### 2. Seed Model Data into MinIO
Initialize the dataset:

```bash
./compose init-stormsim
```

### 3. Build the Container
From the project root (the directory containing both `cc-demo` and `cc-py-sdk`):

```bash
docker build -f cc-demo/stormsim-mock-plugin/export.Dockerfile   -t cc-stormsim-plugin-test .
```
