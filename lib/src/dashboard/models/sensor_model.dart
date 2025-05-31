class SensorModel {
  SensorModel({
    required this.average,
    required this.chart,
    required this.sensors,
  });

  final double? average;
  final List<Chart> chart;
  final List<Sensor> sensors;

  factory SensorModel.fromJson(Map<String, dynamic> json){
    return SensorModel(
      average: double.tryParse(json["average"].toString()),
      chart: json["chart"] == null ? [] : List<Chart>.from(json["chart"]!.map((x) => Chart.fromJson(x))),
      sensors: json["sensors"] == null ? [] : List<Sensor>.from(json["sensors"]!.map((x) => Sensor.fromJson(x))),
    );
  }

}

class Chart {
  Chart({
    required this.x,
    required this.y,
  });

  final String? x;
  final double? y;

  factory Chart.fromJson(Map<String, dynamic> json){
    return Chart(
      x: json["x"],
      y: double.tryParse(json["y"].toString()),
    );
  }

}

class Sensor {
  Sensor({
    required this.id,
    required this.code,
    required this.deviceId,
    required this.type,
    required this.lastestValue,
    required this.lastUpdatedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.iotSensor,
  });

  final String? id;
  final String? code;
  final String? deviceId;
  final String? type;
  final double? lastestValue;
  final int? lastUpdatedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final IotSensor? iotSensor;

  factory Sensor.fromJson(Map<String, dynamic> json){
    return Sensor(
      id: json["id"],
      code: json["code"],
      deviceId: json["deviceId"],
      type: json["type"],
      lastestValue: double.tryParse(json["lastestValue"].toString()),
      lastUpdatedAt: json["lastUpdatedAt"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      iotSensor: json["IotSensor"] == null ? null : IotSensor.fromJson(json["IotSensor"]),
    );
  }

}

class IotSensor {
  IotSensor({
    required this.id,
    required this.name,
    required this.code,
    required this.cageId,
    required this.tempThreshold,
    required this.humidityThreshold,
    required this.amoniaThreshold,
    required this.ldrThreshold,
    required this.tempMinThreshold,
    required this.humidityMinThreshold,
    required this.amoniaMinThreshold,
    required this.currentTemperature,
    required this.currentHumidty,
    required this.currentAmonia,
    required this.currentAirQuality,
    required this.lampStatus,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? name;
  final String? code;
  final String? cageId;
  final int? tempThreshold;
  final int? humidityThreshold;
  final int? amoniaThreshold;
  final int? ldrThreshold;
  final dynamic tempMinThreshold;
  final dynamic humidityMinThreshold;
  final dynamic amoniaMinThreshold;
  final dynamic currentTemperature;
  final dynamic currentHumidty;
  final dynamic currentAmonia;
  final dynamic currentAirQuality;
  final dynamic lampStatus;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory IotSensor.fromJson(Map<String, dynamic> json){
    return IotSensor(
      id: json["id"],
      name: json["name"],
      code: json["code"],
      cageId: json["cageId"],
      tempThreshold: json["tempThreshold"],
      humidityThreshold: json["humidityThreshold"],
      amoniaThreshold: json["amoniaThreshold"],
      ldrThreshold: json["ldrThreshold"],
      tempMinThreshold: json["tempMinThreshold"],
      humidityMinThreshold: json["humidityMinThreshold"],
      amoniaMinThreshold: json["amoniaMinThreshold"],
      currentTemperature: json["currentTemperature"],
      currentHumidty: json["currentHumidty"],
      currentAmonia: json["currentAmonia"],
      currentAirQuality: json["currentAirQuality"],
      lampStatus: json["lampStatus"],
      deletedAt: json["deletedAt"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

}