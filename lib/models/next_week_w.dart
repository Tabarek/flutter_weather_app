// To parse this JSON data, do
//
//     final nextWeekWeatherModel = nextWeekWeatherModelFromJson(jsonString);

import 'dart:convert';

NextWeekWeathModel nextWeekWeatherModelFromJson(String str) =>
    NextWeekWeathModel.fromJson(json.decode(str));

String nextWeekWeatherModelToJson(NextWeekWeathModel data) =>
    json.encode(data.toJson());

class NextWeekWeathModel {
  NextWeekWeathModel({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezoneOffset,
    required this.current,
    required this.daily,
  });

  double? lat;
  double? lon;
  String timezone;
  int timezoneOffset;
  Current current;
  List<Daily> daily;

  NextWeekWeathModel copyWith({
    double? lat,
    double? lon,
    String? timezone,
    int? timezoneOffset,
    Current? current,
    List<Daily>? daily,
  }) =>
      NextWeekWeathModel(
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        timezone: timezone ?? this.timezone,
        timezoneOffset: timezoneOffset ?? this.timezoneOffset,
        current: current ?? this.current,
        daily: daily ?? this.daily,
      );

  factory NextWeekWeathModel.fromJson(Map<String, dynamic> json) =>
      NextWeekWeathModel(
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        timezone: json["timezone"],
        timezoneOffset: json["timezone_offset"],
        current: Current.fromJson(json["current"]),
        daily: List<Daily>.from(json["daily"].map((x) => Daily.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
        "timezone": timezone,
        "timezone_offset": timezoneOffset,
        "current": current.toJson(),
        "daily": List<dynamic>.from(daily.map((x) => x.toJson())),
      };
}

class Current {
  Current({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.uvi,
    required this.clouds,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    required this.weather,
  });

  int dt;
  int sunrise;
  int sunset;
  double? temp;
  double? feelsLike;
  int pressure;
  int humidity;
  double? dewPoint;
  double uvi;
  int clouds;
  int visibility;
  double? windSpeed;
  int windDeg;
  List<Weather> weather;

  Current copyWith({
    int? dt,
    int? sunrise,
    int? sunset,
    double? temp,
    double? feelsLike,
    int? pressure,
    int? humidity,
    double? dewPoint,
    double? uvi,
    int? clouds,
    int? visibility,
    double? windSpeed,
    int? windDeg,
    List<Weather>? weather,
  }) =>
      Current(
        dt: dt ?? this.dt,
        sunrise: sunrise ?? this.sunrise,
        sunset: sunset ?? this.sunset,
        temp: temp ?? this.temp,
        feelsLike: feelsLike ?? this.feelsLike,
        pressure: pressure ?? this.pressure,
        humidity: humidity ?? this.humidity,
        dewPoint: dewPoint ?? this.dewPoint,
        uvi: uvi ?? this.uvi,
        clouds: clouds ?? this.clouds,
        visibility: visibility ?? this.visibility,
        windSpeed: windSpeed ?? this.windSpeed,
        windDeg: windDeg ?? this.windDeg,
        weather: weather ?? this.weather,
      );

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        dt: json["dt"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        temp: json["temp"].toDouble(),
        feelsLike: json["feels_like"].toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
        dewPoint: json["dew_point"].toDouble(),
        uvi: json["uvi"],
        clouds: json["clouds"],
        visibility: json["visibility"],
        windSpeed: json["wind_speed"].toDouble(),
        windDeg: json["wind_deg"],
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "sunrise": sunrise,
        "sunset": sunset,
        "temp": temp,
        "feels_like": feelsLike,
        "pressure": pressure,
        "humidity": humidity,
        "dew_point": dewPoint,
        "uvi": uvi,
        "clouds": clouds,
        "visibility": visibility,
        "wind_speed": windSpeed,
        "wind_deg": windDeg,
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
      };
}

class Weather {
  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  int id;
  String main;
  String description;
  String icon;

  Weather copyWith({
    int? id,
    String? main,
    String? description,
    String? icon,
  }) =>
      Weather(
        id: id ?? this.id,
        main: main ?? this.main,
        description: description ?? this.description,
        icon: icon ?? this.icon,
      );

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };
}

class Daily {
  Daily({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.weather,
    required this.clouds,
    required this.pop,
    required this.uvi,
  });

  int dt;
  int sunrise;
  int sunset;
  int moonrise;
  int moonset;
  double? moonPhase;
  Temp temp;
  FeelsLike feelsLike;
  int pressure;
  int humidity;
  double? dewPoint;
  double? windSpeed;
  int windDeg;
  double? windGust;
  List<Weather> weather;
  int clouds;
  int pop;
  double? uvi;

  Daily copyWith({
    int? dt,
    int? sunrise,
    int? sunset,
    int? moonrise,
    int? moonset,
    double? moonPhase,
    Temp? temp,
    FeelsLike? feelsLike,
    int? pressure,
    int? humidity,
    double? dewPoint,
    double? windSpeed,
    int? windDeg,
    double? windGust,
    List<Weather>? weather,
    int? clouds,
    int? pop,
    double? uvi,
  }) =>
      Daily(
        dt: dt ?? this.dt,
        sunrise: sunrise ?? this.sunrise,
        sunset: sunset ?? this.sunset,
        moonrise: moonrise ?? this.moonrise,
        moonset: moonset ?? this.moonset,
        moonPhase: moonPhase ?? this.moonPhase,
        temp: temp ?? this.temp,
        feelsLike: feelsLike ?? this.feelsLike,
        pressure: pressure ?? this.pressure,
        humidity: humidity ?? this.humidity,
        dewPoint: dewPoint ?? this.dewPoint,
        windSpeed: windSpeed ?? this.windSpeed,
        windDeg: windDeg ?? this.windDeg,
        windGust: windGust ?? this.windGust,
        weather: weather ?? this.weather,
        clouds: clouds ?? this.clouds,
        pop: pop ?? this.pop,
        uvi: uvi ?? this.uvi,
      );

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        dt: json["dt"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        moonrise: json["moonrise"],
        moonset: json["moonset"],
        moonPhase: json["moon_phase"].toDouble(),
        temp: Temp.fromJson(json["temp"]),
        feelsLike: FeelsLike.fromJson(json["feels_like"]),
        pressure: json["pressure"],
        humidity: json["humidity"],
        dewPoint: json["dew_point"].toDouble(),
        windSpeed: json["wind_speed"].toDouble(),
        windDeg: json["wind_deg"],
        windGust: json["wind_gust"].toDouble(),
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        clouds: json["clouds"],
        pop: json["pop"],
        uvi: json["uvi"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "sunrise": sunrise,
        "sunset": sunset,
        "moonrise": moonrise,
        "moonset": moonset,
        "moon_phase": moonPhase,
        "temp": temp.toJson(),
        "feels_like": feelsLike.toJson(),
        "pressure": pressure,
        "humidity": humidity,
        "dew_point": dewPoint,
        "wind_speed": windSpeed,
        "wind_deg": windDeg,
        "wind_gust": windGust,
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "clouds": clouds,
        "pop": pop,
        "uvi": uvi,
      };
}

class FeelsLike {
  FeelsLike({
    required this.day,
    required this.night,
    required this.eve,
    required this.morn,
  });

  double? day;
  double? night;
  double? eve;
  double? morn;

  FeelsLike copyWith({
    double? day,
    double? night,
    double? eve,
    double? morn,
  }) =>
      FeelsLike(
        day: day ?? this.day,
        night: night ?? this.night,
        eve: eve ?? this.eve,
        morn: morn ?? this.morn,
      );

  factory FeelsLike.fromJson(Map<String, dynamic> json) => FeelsLike(
        day: json["day"].toDouble(),
        night: json["night"].toDouble(),
        eve: json["eve"].toDouble(),
        morn: json["morn"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "night": night,
        "eve": eve,
        "morn": morn,
      };
}

class Temp {
  Temp({
    required this.day,
    required this.min,
    required this.max,
    required this.night,
    required this.eve,
    required this.morn,
  });

  double? day;
  double? min;
  double? max;
  double? night;
  double? eve;
  double? morn;

  Temp copyWith({
    double? day,
    double? min,
    double? max,
    double? night,
    double? eve,
    double? morn,
  }) =>
      Temp(
        day: day ?? this.day,
        min: min ?? this.min,
        max: max ?? this.max,
        night: night ?? this.night,
        eve: eve ?? this.eve,
        morn: morn ?? this.morn,
      );

  factory Temp.fromJson(Map<String, dynamic> json) => Temp(
        day: json["day"].toDouble(),
        min: json["min"].toDouble(),
        max: json["max"].toDouble(),
        night: json["night"].toDouble(),
        eve: json["eve"].toDouble(),
        morn: json["morn"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "min": min,
        "max": max,
        "night": night,
        "eve": eve,
        "morn": morn,
      };
}
