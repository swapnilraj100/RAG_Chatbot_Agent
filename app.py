%%bash
cat > app.py <<'EOF'
import joblib, os
from flask import Flask, request, jsonify

model, labels = joblib.load("models/text_nb_pipeline.joblib")

app = Flask(__name__)

@app.route("/health", methods=["GET"])
def health():
    return "ok", 200

@app.route("/predict", methods=["POST"])
def predict():
    payload = request.json or {}
    text = payload.get("text", "")
    if not text:
        return jsonify({"error": "no text provided"}), 400
    pred = model.predict([text])[0]
    return jsonify({"label_index": int(pred), "label": labels[pred]})
EOF
