FROM python:3.11-slim

WORKDIR /app

# Install system dependencies needed for scikit-learn & numpy
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    python3-dev \
    libgomp1 \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first (better caching in Docker)
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# Copy application code and models
COPY app.py .
COPY models ./models

EXPOSE 5000

# Gunicorn with 2 workers and 120s timeout
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app", "--workers", "2", "--timeout", "120"]
