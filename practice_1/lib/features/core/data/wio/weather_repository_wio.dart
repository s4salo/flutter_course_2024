import 'package:practice_1/features/core/data/wio/models/wio_weather.dart';
import 'package:practice_1/features/core/data/wio/wio_api.dart';

import '../../domain/entities/search_query.dart';
import '../../domain/entities/search_response.dart';
import '../../domain/repositories/weather_repository.dart';

class WeatherRepositoryWIO implements WeatherRepository {
  final WIOApi _api;

  WeatherRepositoryWIO(this._api);

  @override
  Future<SearchResponse> getWeather(SearchQuery query) async {
    if (query is SearchQueryViaCity) {
      var response = await _api.getWeather(query.city);
      return SearchResponse(response.temp.toDouble(), _weatherType(response.type));
    } else if (query is SearchQueryViaCords) {
      var response = await _api.getWeatherViaCords(query.lat, query.long);
      return SearchResponse(response.temp.toDouble(), _weatherType(response.type));
    } else {
      throw ArgumentError();
    }
  }

  WeatherType _weatherType(String type) {
    final lowerType = type.toLowerCase();

    if (lowerType.contains('clouds')) {
      return WeatherType.cloudy;
    } else if (lowerType.contains('clear')) {
      return WeatherType.clear;
    } else if (lowerType.contains('rain')) {
      return WeatherType.rain;
    } else {
      return WeatherType.other;
    }
  }
}