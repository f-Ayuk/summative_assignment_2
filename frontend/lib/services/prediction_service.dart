import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/flight_data.dart';

class PredictionService {
  static const String _baseUrl =
      'https://airwaves1.onrender.com'; // Replace with actual FastAPI URL

  /// Fetches flight delay prediction from the FastAPI backend
  static Future<double> getPrediction(FlightData flightData) async {
    final url = Uri.parse('$_baseUrl/predict'); // Ensure only one '/predict'

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(flightData.toJson()),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data.containsKey('predicted_arrival_delay')) {
          return (data['predicted_arrival_delay'] as num).toDouble();
        } else {
          throw Exception(
            'Invalid response format: Missing "predicted_arrival_delay" key.',
          );
        }
      } else {
        throw Exception(
          'Failed to predict delay. Status Code: ${response.statusCode}, Body: ${response.body}',
        );
      }
    } catch (e) {
      print('Error in PredictionService: $e');
      rethrow; // Allow error to propagate for better debugging
    }
  }
}
