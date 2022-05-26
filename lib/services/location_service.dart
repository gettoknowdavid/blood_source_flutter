import 'dart:async';

import 'package:blood_source/models/user_location.dart';
import 'package:location/location.dart';
import 'package:stacked/stacked.dart';
import 'package:logger/logger.dart';
import 'package:geocoding/geocoding.dart' as geo;

class LocationService with ReactiveServiceMixin {
  Logger logger = Logger();
  late final Location _location = Location();

  final ReactiveValue<UserLocation?> _loc = ReactiveValue<UserLocation?>(null);
  UserLocation? get loc => _loc.value;

  final ReactiveValue<geo.Placemark?> _place =
      ReactiveValue<geo.Placemark?>(null);
  geo.Placemark? get place => _place.value;

  LocationService() {
    listenToReactiveValues([_loc, _place]);

    _location.requestPermission().then((PermissionStatus granted) {
      if (granted == PermissionStatus.granted) {
        _location.onLocationChanged.listen((LocationData? data) {
          if (data != null) {
            _loc.value = UserLocation(data.latitude!, data.longitude!);
          }
        });
      }
    });
  }

  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await _location.getLocation();
      _loc.value = UserLocation(
        userLocation.latitude!,
        userLocation.longitude!,
      );
    } on Exception catch (e) {
      logger.e(e.toString());
    }

    return _loc.value!;
  }

  Future<String> getPlace() async {
    await getLocation();
    List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
      _loc.value!.latitude,
      _loc.value!.longitude,
    );
    geo.Placemark place = placemarks[0];
    geo.Placemark place2 = placemarks[1];

    _place.value = place;
    String _currentAddress =
        "${place.name} ${place2.name} ${place.subLocality} ${place.subAdministrativeArea} ${place.postalCode}";
    logger.i(_currentAddress);
    return _currentAddress;
  }
}
