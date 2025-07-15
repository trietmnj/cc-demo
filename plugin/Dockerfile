# plugin/Dockerfile
FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

COPY ../plugin/requirements.dev.txt /tmp/requirements.dev.txt
RUN pip install --upgrade pip && \
    pip install -r /tmp/requirements.dev.txt

# default command - can override if needed
CMD ["python", "plugin/main.py"]
