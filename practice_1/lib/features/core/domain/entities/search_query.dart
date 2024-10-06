abstract class SearchQuery {}

class SearchQueryViaCity extends SearchQuery {
  final String city;

  SearchQueryViaCity(this.city);
}

class SearchQueryViaCords extends SearchQuery {
  final double lat;
  final double long;

  SearchQueryViaCords(this.lat, this.long);
}