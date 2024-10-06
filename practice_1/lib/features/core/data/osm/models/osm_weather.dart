class OSMWeather {
  final int temp;
  final String type;

  const OSMWeather(this.temp, this.type);

  @override
  String toString() {
    return 'OSMWeather{temp: $temp, type: $type}';
  }
}