# cc-demo

---

## Workflow

### 1. Clone the SDK

Clone `cc-py-sdk` from USACE into the **same parent directory** as this repo. This allows you to develop both the SDK and plugin in tandem.

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

---

### 2. Make `compose.sh` Executable
```bash
chmod u+x compose.sh
```

---

### 3. Start Local Infrastructure
```bash
./compose.sh infras-up
```

---

### 4. Setup Local S3 for DAG Payload

1. Open the MinIO console at [http://localhost:9000](http://localhost:9000).
2. Create a bucket named `ccstore`.
3. Generate a GUID (or use this sample: `8cf898dd-bda6-4993-87b6-f281539b26a7`).
4. Create a path in the bucket:
   `cc_store/{your-GUID}`
   Example: `cc_store/8cf898dd-bda6-4993-87b6-f281539b26a7`
5. Upload your sample payload to that path using the object key:
   `cc_store/{your-GUID}/payload`
   > 🔒 The object key must be exactly `payload`, **not** `payload.json`.

---

### 5. Develop Your Plugin

- Develop your plugin in the `plugin/` directory.
- Optionally modify the SDK in `../cc-py-sdk/src/cc`.
- The plugin's entry point must be: `plugin/main.py`.

---

### (Optional) 5a. Setup Local S3 for FFRD Data

1. Open the MinIO console at [http://localhost:9000](http://localhost:9000).
2. Create a bucket named `ffrd`.
3. Upload the following files to:
   `ffrd/model-library/ffrd-store/`
   - `hw.txt`
   - `hwout.ttx`

---

### 6. Test the Plugin

**Run the plugin container:**

```bash
./compose.sh plugin-up
```

### (Optional) 6a. Connect VSCode to the container

Start the plugin container in interactive mode

```bash
./compose.sh plugin-it-up
```

Then connect to the container using VSCode

```plaintext
> Dev Containers: Attach to Running Container...
```

---

## 📚 References

- [Directed Acyclic Graph (DAG) – Wikipedia](https://en.wikipedia.org/wiki/Directed_acyclic_graph)
