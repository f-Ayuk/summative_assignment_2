from fastapi import FastAPI
from pydantic import BaseModel
from fastapi.middleware.cors import CORSMiddleware
import joblib
import numpy as np

# Load the trained model
model = joblib.load('best_model.pkl')

app = FastAPI()


@app.get("/")
def read_root():
    return {"message": "Flight Delay Prediction API is running!"}


# Enable CORS for frontend communication
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Update this to restrict access
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Define the input data model
class FlightData(BaseModel):
    airline: str
    flight_number: str
    departure_airport: str
    arrival_airport: str
    scheduled_hour: int
    day_of_week: int
    temperature: float
    wind_speed: float
    precipitation: float
    visibility: float
    air_traffic: int



@app.get("/")
def home():
    return {"message": "Flight Delay Prediction API is running!"}


# Prediction route
@app.post('/predict')
def predict(flight_data: FlightData):
    # Preprocess input data for prediction
    features = np.array([[
        flight_data.scheduled_hour,
        flight_data.day_of_week,
        flight_data.temperature,
        flight_data.wind_speed,
        flight_data.precipitation,
        flight_data.visibility,
        flight_data.air_traffic
    ]])

    # Predict the arrival delay
    predicted_delay = model.predict(features)

    return {"predicted_arrival_delay": predicted_delay[0]}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="127.0.0.1", port=8000)
