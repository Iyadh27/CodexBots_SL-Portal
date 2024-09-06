import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // List of hotspot coordinates and descriptions
  final List<LatLng> hotspots = [
    LatLng(51.509364, -0.128928), // Central London
    LatLng(51.513200, -0.098351), // Hotspot 1
    LatLng(51.500152, -0.126236), // Hotspot 2
    LatLng(51.515617, -0.091998), // Hotspot 3
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover Nearby Places'),
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter:
              LatLng(51.509364, -0.128928), // Center the map over London
          initialZoom: 12,
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
            userAgentPackageName: 'com.example.app',
            maxNativeZoom: 19,
          ),
          RichAttributionWidget(
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
                onTap: () => print('OpenStreetMap clicked'),
              ),
            ],
          ),
          // Add MarkerLayer for the hotspots
          MarkerLayer(
            markers: hotspots.map((point) {
              return Marker(
                point: point,
                width: 80,
                height: 80,
                child: Icon(
                  Icons.location_on,
                  color: Colors.teal[700],
                  size: 40.0,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
