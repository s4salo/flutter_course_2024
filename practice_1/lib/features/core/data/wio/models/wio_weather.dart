import 'dart:convert';

class WIOWeather {
  final dynamic temp;
  final String type;

  const WIOWeather(this.temp, this.type);

  @override
  String toString() {
    return 'WIOWeather{temp: $temp, type: $type}';
  }
}