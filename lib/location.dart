import 'package:geolocator/geolocator.dart';

class Location {
  double latitude = 0;
  double longitude = 0;
  String _locationData = '';

  Future<void> getcurrentlocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      _locationData =
          'Latitude: ${position.latitude}\nLongitude: ${position.longitude}';
      latitude = position.latitude;
      longitude = position.longitude;
      // print(_locationData);
      if (position == null) {
        print('Failed to get location data');
        return;
      }
      ;
    } catch (e) {
      print(e);
    }
  }
}
