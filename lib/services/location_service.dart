import 'dart:async';

import 'package:blood_source/models/user_location.dart';
import 'package:location/location.dart';
import 'package:stacked/stacked.dart';
import 'package:logger/logger.dart';
import 'package:geocoding/geocoding.dart' as geo;

class LocationService with ReactiveServiceMixin {
  Logger logger = Logger();
  late final Location _location = Location();

  final ReactiveValue<UserLocation?> _loc = ReactiveValue<UserLocation?>(
    const UserLocation(0.0, 0.0),
  );
  UserLocation? get loc => _loc.value;

  // final ReactiveValue<geo.Placemark?> _place =
  //     ReactiveValue<geo.Placemark?>(null);
  // geo.Placemark? get place => _place.value;

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
    try {
      LocationData locData = await _location.getLocation();

      UserLocation _userLoc = UserLocation(
        locData.latitude!,
        locData.longitude!,
      );

      _loc.value = _userLoc;
      logger.i('${_userLoc.latitude} ${_userLoc.longitude}');

      List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
        _loc.value!.latitude,
        _loc.value!.longitude,
      );

      geo.Placemark place = placemarks[0];

      _city.value = place.locality;
    } on Exception catch (e) {
      logger.e(e.toString());
    }

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
