import 'package:practice_1/features/core/data/wio/weather_repository_wio.dart';
import 'package:practice_1/features/core/data/wio/wio_api.dart';
import 'package:practice_1/features/core/presentation/app.dart';

const String version = '0.0.1';
const String urlOSM = 'https://api.openweathermap.org';
const String urlWIO = 'https://api.weatherbit.io';
const String apiKeyOSM = 'f11a8d09666e4acbd56e3ecc1ccbe31b';
const String apiKeyWIO = '1496170a044f4904ae75c1fbc35b04b8';

void main(List<String> arguments) {
  var app = App(WeatherRepositoryWIO(WIOApi(urlWIO, apiKeyWIO)));

  app.run();
}
