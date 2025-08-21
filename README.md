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

### 5. Test the Plugin

**Run the plugin container:**

```bash
./compose.sh plugin-up
```

### (Optional) 5a. Connect VSCode to the container

Start the plugin container in interactive mode

```bash
./compose.sh plugin-it-up
```

Then connect to the container using VSCode

```plaintext
> Dev Containers: Attach to Running Container...
> /cc-plugin
```

---

## 📚 References

- [Directed Acyclic Graph (DAG) – Wikipedia](https://en.wikipedia.org/wiki/Directed_acyclic_graph)
