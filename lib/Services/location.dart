import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class Location {
  double? latitude;
  double? longitude;
  String? city;
  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude!, longitude!);
      city = placemarks[0].locality!.split(' ').first;
      print(city);
    } catch (e) {
      print(e);
    }
  }
}
