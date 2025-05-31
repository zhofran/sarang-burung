class ChickenProductionModel {
  ChickenProductionModel({
    required this.date,
    required this.total,
    required this.totalBiaya,
    required this.totalHarga,
  });

  final DateTime? date;
  final int total;
  final int totalBiaya;
  final int totalHarga;

  factory ChickenProductionModel.fromJson(Map<String, dynamic> json){
    return ChickenProductionModel(
      date: DateTime.tryParse(json["date"] ?? ""),
      total: json["total"] ?? 0,
      totalBiaya: json["totalBiaya"] ?? 0,
      totalHarga: json["totalHarga"] ?? 0,
    );
  }

}

class ChickenProductionSummary {
  ChickenProductionSummary({
    required this.sumHarga,
    required this.sumBiaya,
    required this.sumTotal,
  });

  final int sumHarga;
  final int sumBiaya;
  final int sumTotal;

  factory ChickenProductionSummary.fromJson(Map<String, dynamic> json){
    return ChickenProductionSummary(
      sumHarga: json["sumHarga"] ?? 0,
      sumBiaya: json["sumBiaya"] ?? 0,
      sumTotal: json["sumTotal"] ?? 0,
    );
  }
}
