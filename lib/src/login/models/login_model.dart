import 'package:equatable/equatable.dart';

class LoginModel extends Equatable {
    const LoginModel({
        required this.email,
        required this.id,
        required this.fullName,
        required this.sites,
    });

    final String? email;
    final String? id;
    final String? fullName;
    final List<SiteElement> sites;

    factory LoginModel.fromJson(Map<String, dynamic> json){ 
        return LoginModel(
            email: json["email"],
            id: json["id"],
            fullName: json["fullName"],
            sites: json["sites"] == null ? [] : List<SiteElement>.from(json["sites"]!.map((x) => SiteElement.fromJson(x))),
        );
    }

    @override
    List<Object?> get props => [
    email, id, fullName, sites, ];
}

class SiteElement extends Equatable {
    const SiteElement({
        required this.id,
        required this.userId,
        required this.siteId,
        required this.deletedAt,
        required this.createdAt,
        required this.updatedAt,
        required this.site,
    });

    final String? id;
    final String? userId;
    final String? siteId;
    final dynamic deletedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final SiteModel? site;

    factory SiteElement.fromJson(Map<String, dynamic> json){ 
        return SiteElement(
            id: json["id"],
            userId: json["userId"],
            siteId: json["siteId"],
            deletedAt: json["deletedAt"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            site: json["site"] == null ? null : SiteModel.fromJson(json["site"]),
        );
    }

    @override
    List<Object?> get props => [
    id, userId, siteId, deletedAt, createdAt, updatedAt, site, ];
}

class SiteModel extends Equatable {
    const SiteModel({
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
    final DateTime? deletedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final dynamic provinceId;
    final dynamic cityId;
    final dynamic districtId;
    final dynamic subDistrictId;
    final String? address;

    factory SiteModel.fromJson(Map<String, dynamic> json){ 
        return SiteModel(
            id: json["id"],
            name: json["name"],
            deletedAt: DateTime.tryParse(json["deletedAt"] ?? ""),
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
