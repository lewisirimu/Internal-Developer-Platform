FROM python:3.10-slim

WORKDIR /app

# Install system dependencies if required for ML libraries
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install
COPY requirements.txt .
# In a real scenario, requirements.txt would contain: fastapi, uvicorn, pydantic, pytorch/scikit-learn
RUN pip install --no-cache-dir fastapi uvicorn pydantic

# Copy service code
COPY app.py .

# Expose port (must match values.yaml container port and python script)
EXPOSE 8080

# Run the API
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8080"]
