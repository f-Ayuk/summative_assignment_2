from pydantic import BaseModel, Field

class FlightInput(BaseModel):
    airline: str
    flight_number: int
    departure_airport: str
    arrival_airport: str
    scheduled_hour: int = Field(ge=0, le=23)  # 0-23 hours
    day_of_week: int = Field(ge=0, le=6)  # Monday to Sunday (0-6)
    temperature: float
    wind_speed: float
    precipitation: float
    visibility: float
    air_traffic: int