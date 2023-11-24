import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GeolocationPermissionsScreen(),
    );
  }
}

class GeolocationPermissionsScreen extends StatefulWidget {
  @override
  _GeolocationPermissionsScreenState createState() => _GeolocationPermissionsScreenState();
}

class _GeolocationPermissionsScreenState extends State<GeolocationPermissionsScreen> {
  LocationData? _locationData;
  Location location = Location();

  void _getLocation() async {
    try {
      var userLocation = await location.getLocation();
      setState(() {
        _locationData = userLocation;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _openMaps() async {
    if (_locationData != null) {
      final url = 'https://www.google.com/maps/search/?api=1&query=${_locationData!.latitude},${_locationData!.longitude}';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geolocation Permissions'),
        backgroundColor: const Color(0xff607d8b),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Geolocation Permissions'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getLocation,
              child: Text('Get Current Location'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _openMaps,
              child: Text('Open in Maps'),
            ),
            SizedBox(height: 20),
            if (_locationData != null)
              Column(
                children: [
                  Text('Latitude: ${_locationData!.latitude}'),
                  Text('Longitude: ${_locationData!.longitude}'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
