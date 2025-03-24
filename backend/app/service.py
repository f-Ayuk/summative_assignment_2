import joblib
import numpy as np

# Load the trained model
model = joblib.load("model.pkl")

def predict_delay(data):
    features = np.array([[data.scheduled_hour, data.day_of_week, data.temperature,
                        data.wind_speed, data.precipitation, data.visibility,
                        data.air_traffic]])

    prediction = model.predict(features)[0]
    return {"predicted_arrival_delay": prediction}