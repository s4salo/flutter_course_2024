import 'package:practice_1/features/core/domain/entities/search_query.dart';
import 'package:practice_1/features/core/domain/repositories/weather_repository.dart';
import 'dart:io';

class App {
  final WeatherRepository repository;

  App(this.repository);

  void run() async {
    print('Укажите режим работы:\n\t1 - по городу\n\t2 - по широте и долготе');
    var mode = stdin.readLineSync();
    SearchQuery query;
    String? data;
    String? city;

    switch (mode) {
      case '2':
        print('Введите данные в формате: широта долгота');
        data = stdin.readLineSync();
        break;
      case '1':
        print('Введите город');
        city = stdin.readLineSync();
        break;
      default:
        print('Неверный режим. Завершение программы.');
        return;
    }

    if (data != null) {
      var coords = data.split(' ');
      if (coords.length == 2) {
        try {
          double lat = double.parse(coords[0]);
          double lon = double.parse(coords[1]);
          query = SearchQueryViaCords(lat, lon);
        } catch (e) {
          print('Ошибка при парсинге координат. Завершение программы.');
          return;
        }
      } else {
        print('Неверный формат координат. Завершение программы.');
        return;
      }
    } else if (city != null) {
      query = SearchQueryViaCity(city);
    } else {
      print('Не указаны данные для поиска. Завершение программы.');
      return;
    }

    try {
      var resp = await repository.getWeather(query);
      if (query is SearchQueryViaCity) {
        print('Погода в городе ${(query as SearchQueryViaCity).city}: ${resp.temp}°C, тип: ${resp.type}');
      } else if (query is SearchQueryViaCords) {
        print('Погода по координатам (${(query as SearchQueryViaCords).lat}, ${query.long}): ${resp.temp}°C, тип: ${resp.type}');
      }
    } catch (e) {
      print('Произошла ошибка при получении данных о погоде: $e');
    }
  }
}