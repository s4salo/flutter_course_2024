import 'dart:convert';
import 'models/wio_weather.dart';
import 'package:http/http.dart' as http;

class WIOApi {
  final String urlWIO;
  final String apiKeyWIO;

  WIOApi(this.urlWIO, this.apiKeyWIO);

  Future<WIOWeather> getWeather(String city) async {
    var response = await http.get(Uri.parse('$urlWIO/v2.0/current?city=$city&key=$apiKeyWIO'));
    var rJson = jsonDecode(response.body);

    return WIOWeather(rJson['data'][0]['temp'], rJson['data'][0]['weather']['description']);
  }

  Future<WIOWeather> getWeatherViaCords(double lat, double long) async {
    var response = await http.get(Uri.parse('$urlWIO/v2.0/current?lat=$lat&lon=$long&key=$apiKeyWIO'));
    var rJson = jsonDecode(response.body);

    return WIOWeather(rJson['data'][0]['temp'], rJson['data'][0]['weather']['description']);
  }
}