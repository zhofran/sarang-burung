import 'package:equatable/equatable.dart';

class WeightModel extends Equatable {
    const WeightModel({
        required this.data,
    });

    final List<DataWeight> data;

    factory WeightModel.fromJson(Map<String, dynamic> json){ 
        return WeightModel(
            data: json["data"] == null ? [] : List<DataWeight>.from(json["data"]!.map((x) => DataWeight.fromJson(x))),
        );
    }

    @override
    List<Object?> get props => [
    data, ];
}

class DataWeight extends Equatable {
    const DataWeight({
        required this.id,
        required this.name,
        required this.type,
        required this.weightPerUnit,
        required this.status,
        required this.value,
        required this.siteId,
        required this.date,
        required this.deletedAt,
        required this.createdAt,
        required this.updatedAt,
        required this.site,
    });

    final String? id;
    final String? name;
    final String? type;
    final double? weightPerUnit;
    final String? status;
    final int? value;
    final String? siteId;
    final dynamic date;
    final dynamic deletedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final Site? site;

    factory DataWeight.fromJson(Map<String, dynamic> json){ 
        return DataWeight(
            id: json["id"],
            name: json["name"],
            type: json["type"],
            weightPerUnit: json["weightPerUnit"],
            status: json["status"],
            value: json["value"],
            siteId: json["siteId"],
            date: json["date"],
            deletedAt: json["deletedAt"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            site: json["site"] == null ? null : Site.fromJson(json["site"]),
        );
    }

    @override
    List<Object?> get props => [
    id, name, type, weightPerUnit, status, value, siteId, date, deletedAt, createdAt, updatedAt, site, ];
}

class Site extends Equatable {
    const Site({
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

    final String? id;
    final String? name;
    final dynamic deletedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final dynamic provinceId;
    final dynamic cityId;
    final dynamic districtId;
    final dynamic subDistrictId;
    final String? address;

    factory Site.fromJson(Map<String, dynamic> json){ 
        return Site(
            id: json["id"],
            name: json["name"],
            deletedAt: json["deletedAt"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            provinceId: json["provinceId"],
            cityId: json["cityId"],
            districtId: json["districtId"],
            subDistrictId: json["subDistrictId"],
            address: json["address"],
        );
    }

    @override
    List<Object?> get props => [
    id, name, deletedAt, createdAt, updatedAt, provinceId, cityId, districtId, subDistrictId, address, ];
}
