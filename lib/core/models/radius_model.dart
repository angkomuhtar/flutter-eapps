class RadiusModel {
  final int id;
  final double latitude;
  final double longitude;
  final String name;
  final String status;
  final int radius;

  RadiusModel({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.status,
    required this.radius,
  });

  factory RadiusModel.fromJson(Map<String, dynamic> json) {
    return RadiusModel(
      id: json['id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      name: json['name'],
      status: json['status'],
      radius: json['radius'],
    );
  }
}
