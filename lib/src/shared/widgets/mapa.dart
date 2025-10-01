import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class SimpleMap extends StatelessWidget {
  final double latitude;
  final double longitude;
  final double zoom;

  const SimpleMap({
    super.key,
    required this.latitude,
    required this.longitude,
    this.zoom = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: FlutterMap(
        options: MapOptions(
          // Agora é initialCenter e initialZoom não existem mais; usamos center e zoom diretamente
          initialCenter: LatLng(latitude, longitude),
          initialZoom: zoom,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
            userAgentPackageName: 'com.seuapp',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(latitude, longitude),
                width: 40,
                height: 40,
                child: const Icon(
                  Icons.location_on_rounded,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
