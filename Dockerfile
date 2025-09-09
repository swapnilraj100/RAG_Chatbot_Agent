FROM python:3.11-slim

WORKDIR /app

# Install system dependencies for scikit-learn, numpy
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libgomp1 \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Match your Flask app's port
EXPOSE 5000

# Use Python for demo OR Gunicorn for production
CMD ["python", "app.py"]
