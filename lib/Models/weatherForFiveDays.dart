import 'dart:convert';

WeatherForFiveDayesModel weatherForFiveDayesResponse(String data) {
  final dyn = json.decode(data);
  print(dyn);
  return WeatherForFiveDayesModel.fromJson(dyn);
}

class WeatherForFiveDayesModel {
  String? cod;
  String? message;
  String? cnt;
  List<MainList>? mainlist;
  City? city;

  WeatherForFiveDayesModel(
      {this.cod, this.message, this.cnt, this.mainlist, this.city});

  WeatherForFiveDayesModel.fromJson(Map<String, dynamic> json) {
    cod = json['cod'].toString();
    message = json['message'].toString();
    cnt = json['cnt'].toString();
    if (json['list'] != null) {
      mainlist =
          (json['list'] as List).map((v) => MainList.fromJson(v)).toList();
    }
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
  }
}

class MainList {
  String? dt;
  Main? main;
  List<Weather>? weather;
  Clouds? clouds;
  Wind? wind;
  String? visibility;
  String? pop;
  Sys? sys;
  String? dtTxt;

  MainList(
      {this.dt,
      this.main,
      this.weather,
      this.clouds,
      this.wind,
      this.visibility,
      this.pop,
      this.sys,
      this.dtTxt});

  MainList.fromJson(Map<String, dynamic> json) {
    dt = json['dt'].toString();
    main = json['main'] != null ? new Main.fromJson(json['main']) : null;
    if (json['weather'] != null) {
      weather =
          (json['weather'] as List).map((v) => Weather.fromJson(v)).toList();
    }
    clouds =
        json['clouds'] != null ? new Clouds.fromJson(json['clouds']) : null;
    wind = json['wind'] != null ? new Wind.fromJson(json['wind']) : null;
    visibility = json['visibility'].toString();
    pop = json['pop'].toString();
    sys = json['sys'] != null ? new Sys.fromJson(json['sys']) : null;
    dtTxt = json['dt_txt'].toString();
  }
}

class Main {
  double? temp;
  String? feelsLike;
  double? tempMin;
  double? tempMax;
  String? pressure;
  String? seaLevel;
  String? grndLevel;
  String? humidity;
  String? tempKf;

  Main(
      {this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.seaLevel,
      this.grndLevel,
      this.humidity,
      this.tempKf});

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'] - 272.5 ?? 0;
    feelsLike = json['feels_like'].toString();
    tempMin = json['temp_min'] - 272.5 ?? 0;
    tempMax = json['temp_max'] - 272.5 ?? 0;
    pressure = json['pressure'].toString();
    seaLevel = json['sea_level'].toString();
    grndLevel = json['grnd_level'].toString();
    humidity = json['humidity'].toString();
    tempKf = json['temp_kf'].toString();
  }
}

class Weather {
  String? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    main = json['main'].toString();
    description = json['description'].toString();
    icon = json['icon'].toString();
  }
}

class Clouds {
  String? all;

  Clouds({this.all});

  Clouds.fromJson(Map<String, dynamic> json) {
    all = json['all'].toString();
  }
}

class Wind {
  String? speed;
  String? deg;
  String? gust;

  Wind({this.speed, this.deg, this.gust});

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'].toString();
    deg = json['deg'].toString();
    gust = json['gust'].toString();
  }
}

class Sys {
  String? pod;

  Sys({this.pod});

  Sys.fromJson(Map<String, dynamic> json) {
    pod = json['pod'].toString();
  }
}

class City {
  String? id;
  String? name;
  Coord? coord;
  String? country;
  String? population;
  String? timezone;
  String? sunrise;
  String? sunset;

  City(
      {this.id,
      this.name,
      this.coord,
      this.country,
      this.population,
      this.timezone,
      this.sunrise,
      this.sunset});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    coord = json['coord'] != null ? new Coord.fromJson(json['coord']) : null;
    country = json['country'].toString();
    population = json['population'].toString();
    timezone = json['timezone'].toString();
    sunrise = json['sunrise'].toString();
    sunset = json['sunset'].toString();
  }
}

class Coord {
  String? lat;
  String? lon;

  Coord({this.lat, this.lon});

  Coord.fromJson(Map<String, dynamic> json) {
    lat = json['lat'].toString();
    lon = json['lon'].toString();
  }
}
