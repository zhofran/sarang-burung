class CageModel {
  CageModel({
    required this.name,
    required this.id,
  });

  final String id;
  final String name;

  factory CageModel.fromJson(Map<String, dynamic> json){
    return CageModel(
      id: json["id"],
      name: json["name"],
    );
  }

}