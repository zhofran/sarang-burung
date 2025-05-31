class ChickenChartModel {
  ChickenChartModel({
    required this.alive,
    required this.dead,
    required this.aliveInSick,
    required this.deadDueToIllness,
    required this.productive,
    required this.feedChange,
    required this.spent,
    required this.rejuvenation,
  });

  final int alive;
  final int dead;
  final int aliveInSick;
  final int deadDueToIllness;
  final int productive;
  final int feedChange;
  final int spent;
  final int rejuvenation;

  factory ChickenChartModel.fromJson(Map<String, dynamic> json){
    return ChickenChartModel(
      alive: json["alive"] ?? 0,
      dead: json["dead"] ?? 0,
      aliveInSick: json["alive_in_sick"] ?? 0,
      deadDueToIllness: json["dead_due_to_illness"] ?? 0,
      productive: json["productive"] ?? 0,
      feedChange: json["feed_change"] ?? 0,
      spent: json["spent"] ?? 0,
      rejuvenation: json["rejuvenation"] ?? 0,
    );
  }

}
