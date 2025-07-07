# cc-demo

---

## Workflow

1. Download cc-python-plugin package from github/USACE.
    This is will be the base image, not your customized plugin.

```bash
docker pull ghcr.io/usace/cc-python-plugin:latest
```

2. Clone cc-sample-python-plugin

```bash
git clone https://github.com/USACE/cc-sample-python-plugin
```

3. Add execution permission to `compose.sh`
```bash
chmod u+x compose.sh
```

3. Setup mock local s3 and mqtt services
```bash
./compose.sh infras-up
```

4. Setup local S3

- Go to the minio console `http://localhost:9000`
- Create a bucket named `ccstore`
- generate a GUID or use a sample like this one: `8cf898dd-bda6-4993-87b6-f281539b26a7`
- Create a path in that bucket using the guid you are using `cc_store/{Your GUID}`
   - for example, using the sample guid above, the path would be `cc_store/8cf898dd-bda6-4993-87b6-f281539b26a7`
- upload your sample payload into that path
   - using the same example, the object key would be `cc_store/8cf898dd-bda6-4993-87b6-f281539b26a7/payload`

5. Develop system plugin in `plugin/`

- The entry point must be `plugin/main.py`

6. Test plugin using container

```bash
./compose.sh plugin-up
```
