FROM python:3.11-slim

# Install docker CLI (NOT daemon)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        docker.io \
        ca-certificates \
        curl && \
    rm -rf /var/lib/apt/lists/*

# Install mcp-unify from your fork (local package)
COPY . /app
WORKDIR /app

RUN pip install --no-cache-dir .

# Optional: default config directory
RUN mkdir -p /app/config

EXPOSE 8765

ENTRYPOINT ["mcp-unify"]
CMD ["serve", "--config", "/app/config/gateway.yaml", "--host", "0.0.0.0", "--port", "8765"]
