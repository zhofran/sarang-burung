import 'package:equatable/equatable.dart';

class PanenTelurModel extends Equatable {
    const PanenTelurModel({
        required this.batchInfo,
        required this.cageInfo,
        required this.rakId,
        required this.rakInfo,
        required this.goodEgg,
        required this.badEgg,
    });

    final String? batchInfo;
    final String? cageInfo;
    final String? rakId;
    final String? rakInfo;
    final int? goodEgg;
    final int? badEgg;

    factory PanenTelurModel.fromJson(Map<String, dynamic> json){ 
        return PanenTelurModel(
            batchInfo: json["batchInfo"],
            cageInfo: json["cageInfo"],
            rakId: json["rakId"],
            rakInfo: json["rakInfo"],
            goodEgg: json["good_egg"],
            badEgg: json["bad_egg"],
        );
    }

    Map<String, dynamic> toJson() {
      return {
        "qty": goodEgg ?? 0, // Menggunakan goodEgg sebagai qty
        "qtyCrack": badEgg ?? 0, // Menggunakan badEgg sebagai qtyCrack
        "rackId": rakId ?? ""  // Menggunakan rakInfo sebagai rackId
      };
    }

    @override
    List<Object?> get props => [
    batchInfo, cageInfo, rakId, rakInfo, goodEgg, badEgg, ];
}
