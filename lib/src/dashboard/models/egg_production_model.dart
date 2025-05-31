class EggProductionModel {
  EggProductionModel({
    required this.date,
    required this.totalWeight,
    required this.total,
    required this.totalBiaya,
    required this.totalHarga,
  });

  final DateTime? date;
  final int totalWeight;
  final int total;
  final int totalBiaya;
  final int totalHarga;

  factory EggProductionModel.fromJson(Map<String, dynamic> json){
    return EggProductionModel(
      date: DateTime.tryParse(json["date"] ?? ""),
      totalWeight: json["totalWeight"] ?? 0,
      total: json["total"] ?? 0,
      totalBiaya: json["totalBiaya"] ?? 0,
      totalHarga: json["totalHarga"] ?? 0,
    );
  }

}

class EggProductionSummary {
  EggProductionSummary({
    required this.sumHarga,
    required this.sumBiaya,
    required this.sumTotal,
    required this.sumWeight,
  });

  final int sumHarga;
  final int sumBiaya;
  final int sumTotal;
  final int sumWeight;

  factory EggProductionSummary.fromJson(Map<String, dynamic> json){
    return EggProductionSummary(
      sumHarga: json["sumHarga"] ?? 0,
      sumBiaya: json["sumBiaya"] ?? 0,
      sumTotal: json["sumTotal"] ?? 0,
      sumWeight: json["sumWeight"] ?? 0,
    );
  }
}
