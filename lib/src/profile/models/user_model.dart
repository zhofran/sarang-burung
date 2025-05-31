import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
    const UserModel({
        required this.token,
        required this.user,
    });

    final String? token;
    final User? user;

    factory UserModel.fromJson(Map<String, dynamic> json){ 
        return UserModel(
            token: json["token"],
            user: json["user"] == null ? null : User.fromJson(json["user"]),
        );
    }

    @override
    List<Object?> get props => [
    token, user, ];
}

class User extends Equatable {
    const User({
        required this.email,
        required this.id,
        required this.fullName,
        required this.sites,
    });

    final String? email;
    final String? id;
    final String? fullName;
    final List<SiteElement> sites;

    factory User.fromJson(Map<String, dynamic> json){ 
        return User(
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
    final SiteSite? site;

    factory SiteElement.fromJson(Map<String, dynamic> json){ 
        return SiteElement(
            id: json["id"],
            userId: json["userId"],
            siteId: json["siteId"],
            deletedAt: json["deletedAt"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            site: json["site"] == null ? null : SiteSite.fromJson(json["site"]),
        );
    }

    @override
    List<Object?> get props => [
    id, userId, siteId, deletedAt, createdAt, updatedAt, site, ];
}

class SiteSite extends Equatable {
    const SiteSite({
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

    factory SiteSite.fromJson(Map<String, dynamic> json){ 
        return SiteSite(
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
