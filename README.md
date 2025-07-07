# cc-demo

---

## Workflow

1. Clone cc-py-sdk from USACE so that it will be in the same directory as this repo.
    This local version will allow developing on both the SDK and plugin.

```graphql
parent-folder/
├── cc-demo/
│   ├── docker-compose.yaml
│   ├── plugin/
│   │   ├── main.py
│   │   └── ...
│   └── ...
├── cc-py-sdk/
│   ├── cc/
│   │   ├── plugin_manager.py
│   │   └── ...
│   └── ...
```

```bash
git clone https://github.com/USACE/cc-py-sdk
````

2. Add execution permission to `compose.sh`
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

4. Develop system plugin in `plugin/` or modify the SDK in `../../cc-py-sdk/src/cc`.

- The entry to the plugin must be `plugin/main.py`

5. Test plugin using container

```bash
./compose.sh plugin-up
```
