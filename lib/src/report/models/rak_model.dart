import 'package:equatable/equatable.dart';

class RakModel extends Equatable {
    const RakModel({
        required this.id,
        required this.name,
        required this.code,
        required this.cageId,
        required this.batchId,
        required this.deletedAt,
        required this.createdAt,
        required this.updatedAt,
        required this.batch,
    });

    final String? id;
    final String? name;
    final int? code;
    final String? cageId;
    final String? batchId;
    final dynamic deletedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final Batch? batch;

    factory RakModel.fromJson(Map<String, dynamic> json){ 
        return RakModel(
            id: json["id"],
            name: json["name"],
            code: json["code"],
            cageId: json["cageId"],
            batchId: json["batchId"],
            deletedAt: json["deletedAt"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            batch: json["batch"] == null ? null : Batch.fromJson(json["batch"]),
        );
    }

    @override
    List<Object?> get props => [
    id, name, code, cageId, batchId, deletedAt, createdAt, updatedAt, batch, ];
}

class Batch extends Equatable {
    const Batch({
        required this.id,
        required this.name,
        required this.startDate,
        required this.endDate,
        required this.status,
        required this.siteId,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
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

    factory Batch.fromJson(Map<String, dynamic> json){ 
        return Batch(
            id: json["id"],
            name: json["name"],
            startDate: DateTime.tryParse(json["startDate"] ?? ""),
            endDate: DateTime.tryParse(json["endDate"] ?? ""),
            status: json["status"],
            siteId: json["siteId"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            deletedAt: json["deletedAt"],
        );
    }

    @override
    List<Object?> get props => [
    id, name, startDate, endDate, status, siteId, createdAt, updatedAt, deletedAt, ];
}
