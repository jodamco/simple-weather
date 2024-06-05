import 'package:geolocator/geolocator.dart';

class GeoLocalizationProvider {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  GeoLocalizationProvider();

  Future<Position?> getCoordinates() async {
    final hasPermission = await _hasGeoLocatorAccess();

    if (!hasPermission) {
      return null;
    }

    final position = await _geolocatorPlatform.getCurrentPosition();
    return position;
  }

  Future<bool> _hasGeoLocatorAccess() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }
}
