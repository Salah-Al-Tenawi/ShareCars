// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:url_launcher/url_launcher.dart';

// class Maps extends StatelessWidget {
//   const Maps({super.key});
 
// @override
// Widget build(BuildContext context) {
//     return FlutterMap(
//       options: const MapOptions(
//         initialCenter: LatLng(33.5138, 36.2765), // Center the map over London
//         initialZoom: 9.2,
//       ),
//     children: [
//       TileLayer( // Bring your own tiles
//         urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // For demonstration only
//         userAgentPackageName: 'com.example.app', // Add your app identifier
//         // And many more recommended properties!
//       ),
//       RichAttributionWidget( // Include a stylish prebuilt attribution widget that meets all requirments
//         attributions: [
//           TextSourceAttribution(
//             'OpenStreetMap contributors',
//             onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')), // (external)
//           ),
//           // Also add images...
//         ],
//       ),
//     ],
//   );

// }}