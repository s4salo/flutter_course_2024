import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WeatherPage(),
    );
  }
}

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController _cityController = TextEditingController();
  bool _isLoading = false;
  double? _temperature;
  String? _description;
  String? _errorMessage;

  final String urlWIO = 'https://api.weatherbit.io';
  final String apiKeyWIO = '1496170a044f4904ae75c1fbc35b04b8';

  IconData getWeatherIcon(String description) {
    description = description.toLowerCase();
    if (description.contains('clear')) return Icons.wb_sunny;
    if (description.contains('cloud')) return Icons.cloud;
    if (description.contains('rain')) return Icons.beach_access;
    if (description.contains('snow')) return Icons.ac_unit;
    if (description.contains('thunder')) return Icons.flash_on;
    return Icons.wb_cloudy;
  }

  Color getTemperatureColor(double temp) {
    if (temp < 0) return Colors.blue;
    if (temp < 15) return Colors.lightBlue;
    if (temp < 25) return Colors.orange;
    return Colors.red;
  }

  Future<void> _getWeather() async {
    final city = _cityController.text.trim();

    if (city.isEmpty) {
      setState(() {
        _errorMessage = 'Пожалуйста, введите название города';
        _temperature = null;
        _description = null;
      });
      _showSnackBar('Пожалуйста, введите название города');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _temperature = null;
      _description = null;
    });

    try {
      final response = await http.get(
          Uri.parse('$urlWIO/v2.0/current?city=$city&key=$apiKeyWIO')
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _temperature = data['data'][0]['temp'].toDouble();
          _description = data['data'][0]['weather']['description'];
          _isLoading = false;
        });
      } else {
        throw Exception('Город не найден');
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Ошибка при получении данных';
        _isLoading = false;
      });
      _showSnackBar('Ошибка: ${e.toString()}');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AGWeather'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'Город',
                hintText: 'Введите название города',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_city),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _getWeather,
              icon: const Icon(Icons.search),
              label: _isLoading
                  ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
                  : const Text('Получить погоду'),
            ),
            const SizedBox(height: 16),
            if (_temperature != null && _description != null)
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Icon(
                        getWeatherIcon(_description!),
                        size: 80,
                        color: getTemperatureColor(_temperature!),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '${_temperature!.toStringAsFixed(1)}°C',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: getTemperatureColor(_temperature!),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _description!,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                      const Divider(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.location_on, color: Colors.grey),
                          const SizedBox(width: 8),
                          Text(
                            _cityController.text,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            else if (_errorMessage != null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red),
                    const SizedBox(width: 8),
                    Text(
                      _errorMessage!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }
}