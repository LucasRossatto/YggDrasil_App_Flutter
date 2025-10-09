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
    this.zoom = 14.0,
  });

  @override
  Widget build(BuildContext context) {
    final corner1 = LatLng(latitude + 40, longitude + 40);
    final corner2 = LatLng(latitude - 40, longitude - 40);
    final bounds = LatLngBounds(corner1, corner2);
    return SizedBox(
      height: 300,
      child: FlutterMap(
        options: MapOptions(
          // Agora é initialCenter e initialZoom não existem mais; usamos center e zoom diretamente
          initialCenter: LatLng(latitude, longitude),
          cameraConstraint: CameraConstraint.contain(bounds: bounds),
          initialZoom: zoom,
          maxZoom: 17.0,
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
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 4),
                    ],
                  ),
                  padding: const EdgeInsets.all(2),
                  child: Image.asset(
                    'assets/images/logo-yggdrasil.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
