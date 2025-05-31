import 'package:equatable/equatable.dart';

class GlobalModel extends Equatable {
    const GlobalModel({
        required this.email,
        required this.id,
        required this.fullName,
        required this.photoUrl,
        required this.siteId,
        required this.batchId,
        required this.permissions,
    });

    final String? email;
    final String? id;
    final String? fullName;
    final String? siteId;
    final String? batchId;
    final String? photoUrl;
    final List<String> permissions;

    factory GlobalModel.fromJson(Map<String, dynamic> json){ 
        return GlobalModel(
            email: json["email"],
            id: json["id"],
            fullName: json["fullName"],
            siteId: json["siteId"],
            batchId: json["batchId"],
            photoUrl: json["photoUrl"],
            permissions: List<String>.from(json["permissions"].map((x) => x)),
        );
    }

    // Method to convert object to JSON
    Map<String, dynamic> toJson() {
      return {
        "email": email,
        "id": id,
        "fullName": fullName,
        "siteId": siteId,
        "batchId": batchId,
        "photoUrl": photoUrl,
        "permissions": List<dynamic>.from(permissions.map((x) => x)),
      };
    }

    bool hasPermission(String permission) {
      return permissions.contains(permission) || permissions.contains('*');
    }

    // CopyWith method to update certain properties
    GlobalModel copyWith({
      String? email,
      String? id,
      String? fullName,
      String? siteId,
      String? batchId,
      String? photoUrl,
      List<String>? permissions,
    }) {
      return GlobalModel(
        email: email ?? this.email,
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        siteId: siteId ?? this.siteId,
        batchId: batchId ?? this.batchId,
        permissions: permissions ?? this.permissions,
        photoUrl: photoUrl ?? this.photoUrl,
      );
    }

    @override
    List<Object?> get props => [
    email, id, fullName, siteId, batchId, ];
}
