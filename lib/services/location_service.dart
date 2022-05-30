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

  final ReactiveValue<String?> _city = ReactiveValue<String?>(null);
  String? get city => _city.value;

  LocationService() {
    listenToReactiveValues([_loc, _city]);

    _location.requestPermission().then((PermissionStatus granted) {
      if (granted == PermissionStatus.granted) {
        _location.onLocationChanged.listen((LocationData? data) async {
          if (data != null) {
            _loc.value = UserLocation(data.latitude!, data.longitude!);
            List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
              _loc.value!.latitude,
              _loc.value!.longitude,
            );
            geo.Placemark place = placemarks[0];
            _city.value = place.locality;
          }
        });
      }
    });
  }

  Future<UserLocation> getLocation() async {
    LocationData data = await _location.getLocation();

    UserLocation? _userLoc = UserLocation(data.latitude!, data.longitude!);

    List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
      _loc.value!.latitude,
      _loc.value!.longitude,
    );

    _loc.value = _userLoc;
    _city.value = placemarks[0].locality;

    logger.i(
      'Latitude: ${_loc.value!.latitude}, Longitude: ${_loc.value!.longitude}',
    );

    return _loc.value!;
  }

  // Future getPlace() async {
  //   List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
  //     _loc.value!.latitude,
  //     _loc.value!.longitude,
  //   );
  //   geo.Placemark place = placemarks[0];
  //   geo.Placemark place2 = placemarks[1];

  //   _city.value = place.locality;
  // }
}
