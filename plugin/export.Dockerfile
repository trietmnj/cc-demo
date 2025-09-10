# plugin/export.Dockerfile
FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
PYTHONUNBUFFERED=1

WORKDIR /app

# Copy the plugin code
COPY cc-demo/ /app

# Copy the 'cc' package from cc-py-sdk
COPY cc-py-sdk/src/cc/ /app/cc/

# Install python dependencies
COPY cc-demo/plugin/requirements.dev.txt /tmp/requirements.dev.txt
RUN pip install --upgrade pip && \
pip install -r /tmp/requirements.dev.txt

# default command - can override if needed
CMD ["python", "plugin/main.py"]
