class LocationModel {
  final String id;
  final String name;

  LocationModel({required this.id, required this.name});

  // Factory method for parsing JSON data
  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
