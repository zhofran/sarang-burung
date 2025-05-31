class CctvModel {
  CctvModel({
    required this.id,
    required this.cageId,
    required this.name,
    required this.ipAddress,
    required this.description,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String cageId;
  final String name;
  final String ipAddress;
    final String description;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory CctvModel.fromJson(Map<String, dynamic> json){
    return CctvModel(
      id: json["id"] ?? "",
      cageId: json["cageId"] ?? "",
      name: json["name"] ?? "",
      ipAddress: json["ipAddress"] ?? "",
      description: json["description"] ?? "",
      deletedAt: json["deletedAt"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

}
