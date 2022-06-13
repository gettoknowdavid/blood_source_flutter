import 'dart:async';

import 'package:blood_source/models/user_location.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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
  }

  Future<UserLocation?> getLocation() async {
    return _location
        .requestPermission()
        .then((PermissionStatus permission) async {
      switch (permission) {
        case PermissionStatus.granted:
          bool isConnected = await InternetConnectionChecker().hasConnection;

          if (isConnected) {
            LocationData data = await _location.getLocation();

            UserLocation? _userLoc = UserLocation(
              data.latitude!,
              data.longitude!,
            );

            List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
              _loc.value!.latitude,
              _loc.value!.longitude,
            );

            _loc.value = _userLoc;
            _city.value = placemarks[0].locality;

            return _loc.value!;
          } else {
            return null;
          }
        default:
          return null;
      }
    });
  }
}
