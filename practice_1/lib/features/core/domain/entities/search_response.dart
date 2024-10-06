class SearchResponse {
  final double temp;
  final WeatherType type;

  const SearchResponse(this.temp, this.type);

  @override
  String toString() {
    return 'SearchResponse{temp: $temp, type: $type}';
  }
}

enum WeatherType {clear, rain, cloudy, other}