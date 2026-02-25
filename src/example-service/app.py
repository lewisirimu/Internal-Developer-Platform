from fastapi import FastAPI
from pydantic import BaseModel
import logging

# Configure basic logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI(title="ML Inference Service")

class PredictionRequest(BaseModel):
    feature_1: float
    feature_2: float

class PredictionResponse(BaseModel):
    prediction: float
    confidence: float

@app.get("/health")
def health_check():
    """Kubernetes liveness/readiness probe target."""
    return {"status": "healthy"}

@app.post("/predict", response_model=PredictionResponse)
def predict(request: PredictionRequest):
    """
    Mock prediction endpoint. Replace this with your actual model inference logic
    (e.g., loading a PyTorch model and running a forward pass).
    """
    logger.info(f"Received request: feature_1={request.feature_1}, feature_2={request.feature_2}")
    
    # Mock ML logic
    prediction = (request.feature_1 * 0.5) + (request.feature_2 * 1.2)
    confidence = 0.95
    
    return PredictionResponse(prediction=prediction, confidence=confidence)

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8080)
