import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import '../services/api_service.dart';
import '../models/location_model.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final ApiService _apiService = ApiService();
  final MapController _mapController = MapController();

  LatLng _currentCenter = const LatLng(-7.2575, 112.7521);
  List<Marker> _markers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchLocations();
  }

  Future<void> _fetchLocations() async {
    try {
      final locations = await _apiService.getLocations();
      setState(() {
        _markers = locations.map((loc) {
          return Marker(
            point: LatLng(loc.latitude, loc.longitude),
            width: 100,
            height: 80,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.restaurant, color: Colors.orange, size: 35),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(blurRadius: 3, color: Colors.black26),
                    ],
                  ),
                  child: Text(
                    loc.name,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        }).toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  Future<void> _addRecommendation() async {
    // Offer two choices: use GPS or pick on map
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Sumber Lokasi"),
        content: const Text(
          "Pilih sumber lokasi: gunakan GPS atau pilih di peta.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              // Use GPS flow
              LocationPermission permission =
                  await Geolocator.checkPermission();
              if (permission == LocationPermission.denied) {
                permission = await Geolocator.requestPermission();
                if (permission == LocationPermission.denied) return;
              }

              Position position;
              try {
                position = await Geolocator.getCurrentPosition();
              } catch (e) {
                // On web the user may deny geolocation — fall back to map picker
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Tidak dapat mendapatkan lokasi GPS. Silakan pilih lokasi di peta.',
                    ),
                  ),
                );
                _showMapPicker();
                return;
              }
              if (!mounted) return;

              final nameController = TextEditingController();
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Rekomendasi Kuliner"),
                  content: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: "Misal: Nasi Goreng Pak Kumis",
                      labelText: "Nama Tempat / Menu",
                      icon: Icon(Icons.fastfood, color: Colors.orange),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Batal"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                        if (nameController.text.isEmpty) return;

                        final newLoc = LocationModel(
                          id: '',
                          name: nameController.text,
                          description: '',
                          latitude: position.latitude,
                          longitude: position.longitude,
                        );

                        bool success = await _apiService.addLocation(newLoc);
                        if (success) {
                          _fetchLocations();
                          _mapController.move(
                            LatLng(position.latitude, position.longitude),
                            15,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Rekomendasi berhasil disimpan!"),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        "Simpan",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: const Text("Gunakan GPS"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            onPressed: () {
              Navigator.pop(context);
              _showMapPicker();
            },
            child: const Text(
              "Pilih di Peta",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showMapPicker() async {
    LatLng selected = _currentCenter;
    final pickerController = MapController();
    final nameController = TextEditingController();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              hintText: 'Nama tempat / menu',
                              prefixIcon: Icon(
                                Icons.fastfood,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                          ),
                          onPressed: () async {
                            if (nameController.text.isEmpty) return;
                            final newLoc = LocationModel(
                              id: '',
                              name: nameController.text,
                              description: '',
                              latitude: selected.latitude,
                              longitude: selected.longitude,
                            );
                            bool success = await _apiService.addLocation(
                              newLoc,
                            );
                            if (success) {
                              if (!mounted) return;
                              Navigator.pop(context); // close bottom sheet
                              _fetchLocations();
                              _mapController.move(selected, 15);
                              ScaffoldMessenger.of(this.context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Rekomendasi berhasil disimpan!',
                                  ),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            'Konfirmasi',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: FlutterMap(
                      mapController: pickerController,
                      options: MapOptions(
                        initialCenter: selected,
                        initialZoom: 14.0,
                        onTap: (tapPos, latlng) {
                          setState(() {
                            selected = latlng;
                          });
                        },
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.kuliner.app',
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: selected,
                              width: 60,
                              height: 60,
                              child: const Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 48,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 12.0,
                    ),
                    child: Text(
                      'Ketuk peta untuk memindahkan marker. Koordinat: ${selected.latitude.toStringAsFixed(5)}, ${selected.longitude.toStringAsFixed(5)}',
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KulinerHunt'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchLocations,
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentCenter,
              initialZoom: 14.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.kuliner.app',
              ),
              MarkerLayer(markers: _markers),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton.extended(
              onPressed: _addRecommendation,
              backgroundColor: Colors.orange,
              label: const Text(
                "Rekomendasiin!",
                style: TextStyle(color: Colors.white),
              ),
              icon: const Icon(Icons.add_location_alt, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
