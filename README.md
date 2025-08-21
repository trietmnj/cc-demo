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

### 4. Develop Your Plugin

- Develop your plugin in the `plugin/` directory.
- Optionally modify the SDK in `../cc-py-sdk/src/cc`.
- The plugin's entry point must be: `plugin/main.py`.
- The payload can be updated in `seed/payloads/payload`

---

### (Optional) 5a. Setup Local S3 for access

1. Open the MinIO console at [http://localhost:9000](http://localhost:9000).
2. Setup up id/secret pair and specify in `ffrd.plugin.local.env` and `ffrd.plugin.env` files:
   - `CC_AWS_ACCESS_KEY_ID=your_id`
   - `CC_AWS_SECRET_ACCESS_KEY=your_secret`
   - `FFRD_AWS_ACCESS_KEY_ID=your_id`
   - `FFRD_AWS_SECRET_ACCESS_KEY=your_secret`

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
