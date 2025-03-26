import 'package:flutter/material.dart';
import 'models/flight_data.dart';
import 'services/prediction_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flight Delay Prediction',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FlightDelayPredictionPage(),
    );
  }
}

class FlightDelayPredictionPage extends StatefulWidget {
  const FlightDelayPredictionPage({super.key});

  @override
  FlightDelayPredictionPageState createState() =>
      FlightDelayPredictionPageState();
}

class FlightDelayPredictionPageState extends State<FlightDelayPredictionPage> {
  final _airlineController = TextEditingController();
  final _flightNumberController = TextEditingController();
  final _departureAirportController = TextEditingController();
  final _arrivalAirportController = TextEditingController();
  final _hourController = TextEditingController();
  final _dayOfWeekController = TextEditingController();
  final _temperatureController = TextEditingController();
  final _windSpeedController = TextEditingController();
  final _precipitationController = TextEditingController();
  final _visibilityController = TextEditingController();
  final _airTrafficController = TextEditingController();

  double? _predictedDelay;

  Future<void> _predictDelay() async {
    try {
      final flightData = FlightData(
        airline: _airlineController.text,
        flightNumber: _flightNumberController.text,
        departureAirport: _departureAirportController.text,
        arrivalAirport: _arrivalAirportController.text,
        scheduledHour: int.tryParse(_hourController.text) ?? 0,
        dayOfWeek: int.tryParse(_dayOfWeekController.text) ?? 1,
        temperature: double.tryParse(_temperatureController.text) ?? 20.0,
        windSpeed: double.tryParse(_windSpeedController.text) ?? 5.0,
        precipitation: double.tryParse(_precipitationController.text) ?? 0.0,
        visibility: double.tryParse(_visibilityController.text) ?? 10.0,
        airTraffic: int.tryParse(_airTrafficController.text) ?? 3,
      );

      final predictedDelay = await PredictionService.getPrediction(flightData);
      setState(() {
        _predictedDelay = predictedDelay;
      });
    } catch (e) {
      setState(() {
        _predictedDelay = null;
      });
      print('Error predicting delay: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flight Delay Prediction')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(_airlineController, 'Airline'),
            _buildTextField(_flightNumberController, 'Flight Number'),
            _buildTextField(_departureAirportController, 'Departure Airport'),
            _buildTextField(_arrivalAirportController, 'Arrival Airport'),
            _buildTextField(_hourController, 'Scheduled Hour (0-23)'),
            _buildTextField(_dayOfWeekController, 'Day of Week (1-7)'),
            _buildTextField(_temperatureController, 'Temperature (°C)'),
            _buildTextField(_windSpeedController, 'Wind Speed (km/h)'),
            _buildTextField(_precipitationController, 'Precipitation (mm)'),
            _buildTextField(_visibilityController, 'Visibility (km)'),
            _buildTextField(_airTrafficController, 'Air Traffic (1-5)'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _predictDelay,
              child: Text('Predict Delay'),
            ),
            SizedBox(height: 20),
            Text(
              _predictedDelay != null
                  ? 'Predicted Delay: $_predictedDelay minutes'
                  : 'Enter details and predict',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
        keyboardType: TextInputType.text,
      ),
    );
  }
}