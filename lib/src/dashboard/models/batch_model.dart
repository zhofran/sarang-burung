import 'package:equatable/equatable.dart';

class BatchModel extends Equatable {
    const BatchModel({
        required this.data,
        required this.meta,
    });

    final List<Datum> data;
    final Meta? meta;

    factory BatchModel.fromJson(Map<String, dynamic> json){ 
        return BatchModel(
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        );
    }

    @override
    List<Object?> get props => [
    data, meta, ];
}

class Datum extends Equatable {
    const Datum({
        required this.id,
        required this.name,
        required this.startDate,
        required this.endDate,
        required this.status,
        required this.siteId,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
        required this.site,
    });

    final String? id;
    final String? name;
    final DateTime? startDate;
    final DateTime? endDate;
    final String? status;
    final String? siteId;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final dynamic deletedAt;
    final Site? site;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            id: json["id"],
            name: json["name"],
            startDate: DateTime.tryParse(json["startDate"] ?? ""),
            endDate: DateTime.tryParse(json["endDate"] ?? ""),
            status: json["status"],
            siteId: json["siteId"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            deletedAt: json["deletedAt"],
            site: json["site"] == null ? null : Site.fromJson(json["site"]),
        );
    }

    @override
    List<Object?> get props => [
    id, name, startDate, endDate, status, siteId, createdAt, updatedAt, deletedAt, site, ];
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

class Meta extends Equatable {
    const Meta({
        required this.limit,
        required this.page,
        required this.totalData,
        required this.totalPage,
    });

    final int? limit;
    final int? page;
    final int? totalData;
    final int? totalPage;

    factory Meta.fromJson(Map<String, dynamic> json){ 
        return Meta(
            limit: json["limit"],
            page: json["page"],
            totalData: json["totalData"],
            totalPage: json["totalPage"],
        );
    }

    @override
    List<Object?> get props => [
    limit, page, totalData, totalPage, ];
}
