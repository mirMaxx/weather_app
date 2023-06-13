class Coords {
  final double? lon;
  final double? lat;

  const Coords({this.lat, this.lon});

  factory Coords.fromjson(Map<String, dynamic> json) {
    return Coords(
      lon: json['coord']['lon'],
      lat: json['coord']['lat'],
    );
  }
}

