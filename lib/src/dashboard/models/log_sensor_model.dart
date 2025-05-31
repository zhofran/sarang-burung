class LogSensorModel {
  LogSensorModel({
    required this.id,
    required this.sensorId,
    required this.relayNumber,
    required this.relayDesc,
    required this.status,
    required this.humidity,
    required this.temperature,
    required this.amonia,
    required this.ldrValue,
    required this.createdAt,
    required this.updatedAt,
    required this.sensor,
  });

  final String id;
  final String sensorId;
  final int relayNumber;
  final String relayDesc;
  final int status;
  final int humidity;
  final double temperature;
  final double amonia;
  final int ldrValue;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Sensor? sensor;

  factory LogSensorModel.fromJson(Map<String, dynamic> json){
    return LogSensorModel(
      id: json["id"] ?? "",
      sensorId: json["sensorId"] ?? "",
      relayNumber: json["relayNumber"] ?? 0,
      relayDesc: json["relayDesc"] ?? "",
      status: json["status"] ?? 0,
      humidity: json["humidity"] ?? 0,
      // temperature: json["tœemperature"] ?? 0.0,
      // amonia: json["amonia"] ?? 0.0,
      temperature: double.parse(json["temperature"].toString()),
      amonia: double.parse(json["amonia"].toString()),
      ldrValue: json["ldrValue"] ?? 0,
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      sensor: json["sensor"] == null ? null : Sensor.fromJson(json["sensor"]),
    );
  }

}

class Sensor {
  Sensor({
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
    required this.cage,
  });

  final String id;
  final String name;
  final String code;
  final String cageId;
  final int tempThreshold;
  final int humidityThreshold;
  final int amoniaThreshold;
  final int ldrThreshold;
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
  final Cage? cage;

  factory Sensor.fromJson(Map<String, dynamic> json){
    return Sensor(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      code: json["code"] ?? "",
      cageId: json["cageId"] ?? "",
      tempThreshold: json["tempThreshold"] ?? 0,
      humidityThreshold: json["humidityThreshold"] ?? 0,
      amoniaThreshold: json["amoniaThreshold"] ?? 0,
      ldrThreshold: json["ldrThreshold"] ?? 0,
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
      cage: json["cage"] == null ? null : Cage.fromJson(json["cage"]),
    );
  }

}

class Cage {
  Cage({
    required this.id,
    required this.name,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.siteId,
    required this.width,
    required this.height,
    required this.capacity,
    required this.status,
    required this.batchId,
    required this.site,
  });

  final String id;
  final String name;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String siteId;
  final int width;
  final int height;
  final int capacity;
  final String status;
  final dynamic batchId;
  final Site? site;

  factory Cage.fromJson(Map<String, dynamic> json){
    return Cage(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      deletedAt: json["deletedAt"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      siteId: json["siteId"] ?? "",
      width: json["width"] ?? 0,
      height: json["height"] ?? 0,
      capacity: json["capacity"] ?? 0,
      status: json["status"] ?? "",
      batchId: json["batchId"],
      site: json["site"] == null ? null : Site.fromJson(json["site"]),
    );
  }

}

class Site {
  Site({
    required this.id,
    required this.name,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.provinceId,
    required this.cityId,
    required this.districtId,
    required this.subDistrictId,
    required this.address,
  });

  final String id;
  final String name;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic provinceId;
  final dynamic cityId;
  final dynamic districtId;
  final dynamic subDistrictId;
  final String address;

  factory Site.fromJson(Map<String, dynamic> json){
    return Site(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      deletedAt: json["deletedAt"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      provinceId: json["provinceId"],
      cityId: json["cityId"],
      districtId: json["districtId"],
      subDistrictId: json["subDistrictId"],
      address: json["address"] ?? "",
    );
  }

}
