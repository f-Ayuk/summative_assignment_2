class FlightData {
  final String airline;
  final String flightNumber;
  final String departureAirport;
  final String arrivalAirport;
  final int scheduledHour;
  final int dayOfWeek;
  final double temperature;
  final double windSpeed;
  final double precipitation;
  final double visibility;
  final int airTraffic;

  FlightData({
    required this.airline,
    required this.flightNumber,
    required this.departureAirport,
    required this.arrivalAirport,
    required this.scheduledHour,
    required this.dayOfWeek,
    required this.temperature,
    required this.windSpeed,
    required this.precipitation,
    required this.visibility,
    required this.airTraffic,
  });

  Map<String, dynamic> toJson() {
    return {
      'airline': airline,
      'flight_number': flightNumber,
      'departure_airport': departureAirport,
      'arrival_airport': arrivalAirport,
      'scheduled_hour': scheduledHour,
      'day_of_week': dayOfWeek,
      'temperature': temperature,
      'wind_speed': windSpeed,
      'precipitation': precipitation,
      'visibility': visibility,
      'air_traffic': airTraffic,
    };
  }
}
