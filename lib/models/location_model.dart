class LocationModel {
  final String id;
  final String name; // Nama Warung / Makanan
  final String description;
  final double latitude;
  final double longitude;

  LocationModel({
    required this.id,
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown',
      description: json['description'] ?? '',
      // Parse latitude safely from various data types (string, int, double)
      latitude: double.tryParse(json['latitude'].toString()) ?? 0.0,
      // Parse longitude safely from various data types (string, int, double)
      longitude: double.tryParse(json['longitude'].toString()) ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
