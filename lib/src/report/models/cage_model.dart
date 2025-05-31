import 'package:equatable/equatable.dart';

class CageModel extends Equatable {
    const CageModel({
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

    final String? id;
    final String? name;
    final dynamic deletedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final String? siteId;
    final int? width;
    final int? height;
    final int? capacity;
    final String? status;
    final dynamic batchId;
    final Site? site;

    factory CageModel.fromJson(Map<String, dynamic> json){ 
        return CageModel(
            id: json["id"],
            name: json["name"],
            deletedAt: json["deletedAt"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            siteId: json["siteId"],
            width: json["width"],
            height: json["height"],
            capacity: json["capacity"],
            status: json["status"],
            batchId: json["batchId"],
            site: json["site"] == null ? null : Site.fromJson(json["site"]),
        );
    }

    @override
    List<Object?> get props => [
    id, name, deletedAt, createdAt, updatedAt, siteId, width, height, capacity, status, batchId, site, ];
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
