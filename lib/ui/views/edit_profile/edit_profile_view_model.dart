import 'dart:async';
import 'dart:io';

import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/models/blood_group.dart';
import 'package:blood_source/models/gender.dart';
import 'package:blood_source/models/user_location.dart';
import 'package:blood_source/services/auth_service.dart';
import 'package:blood_source/services/location_service.dart';
import 'package:blood_source/services/media_service.dart';
import 'package:blood_source/services/storage_service.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:blood_source/ui/shared/setup_snack_bar_ui.dart';
import 'package:blood_source/utils/dialog_type.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class EditProfileViewModel extends ReactiveViewModel with ReactiveServiceMixin {
  EditProfileViewModel() {
    listenToReactiveValues([_image, _photoUrl, _gender]);

    subscription = InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          isConnected = true;
          notifyListeners();
          break;
        case InternetConnectionStatus.disconnected:
          isConnected = false;
          notifyListeners();
          break;
      }
    });
  }

  late StreamSubscription<InternetConnectionStatus> subscription;

  final AuthService _authService = locator<AuthService>();
  final DialogService _dialogService = locator<DialogService>();
  final StoreService _storeService = locator<StoreService>();
  final MediaService _mediaService = locator<MediaService>();
  final NavigationService _navService = locator<NavigationService>();
  final StorageService _storageService = locator<StorageService>();
  final LocationService _locService = locator<LocationService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

  final ReactiveValue<File?> _image = ReactiveValue<File?>(null);
  File? get image => _image.value;

  final ReactiveValue<String?> _photoUrl = ReactiveValue<String?>(null);
  String? get photoUrl => _photoUrl.value;

  late final ReactiveValue<Gender> _gender =
      ReactiveValue<Gender>(user.gender!);
  Gender get gender => _gender.value;

  late final ReactiveValue<BloodGroup> _bloodGroup =
      ReactiveValue<BloodGroup>(user.bloodGroup!);
  BloodGroup get bloodType => _bloodGroup.value;

  BloodSourceUser get user => _storeService.bsUser!;
  String? get city => _locService.city;
  UserLocation? get location => _locService.loc;
  bool? isConnected;

  void getImage() async {
    final _pickedFile = await _mediaService.getImage(fromGallery: true);

    if (_pickedFile != null) {
      _image.value = File(_pickedFile.path);
    }

    notifyListeners();
  }

  late TextEditingController nameController = TextEditingController(
    text: user.name,
  );
  late TextEditingController weightController = TextEditingController(
    text: user.weight == null ? '' : user.weight.toString(),
  );
  late TextEditingController heightController = TextEditingController(
    text: user.height == null ? '' : user.height.toString(),
  );
  late TextEditingController ageController = TextEditingController(
    text: user.age == null ? '' : user.age.toString(),
  );
  late TextEditingController phoneController = TextEditingController(
    text: user.phone,
  );

  Future getLocation() async {
    await _locService.getLocation();
  }

  void Function(Gender?)? onGenderChanged(Gender? newValue) {
    _gender.value = newValue!;
    notifyListeners();
    return null;
  }

  void Function(BloodGroup?)? onBloodGroupChanged(BloodGroup? newValue) {
    _bloodGroup.value = newValue!;
    notifyListeners();
    return null;
  }

  IconData? getGenderIcon(Gender e) {
    switch (e) {
      case Gender.male:
        return Icons.man_rounded;
      case Gender.female:
        return Icons.woman_rounded;
      case Gender.none:
        return Icons.transgender;
      default:
        return Icons.transgender;
    }
  }

  Future<BloodSourceUser?> save(bool isFirstEdit) async {
    _dialogService.showCustomDialog(variant: DialogType.loading);

    final name = "${user.uid}.jpg";

    if (_image.value != null) {
      final ref = _storageService.storageRef.child("images/avatar/$name");

      await _storageService.uploadFileToCloud(_image.value!.path, name, ref);

      _photoUrl.value = await _storageService.getFileFromCloud(ref);
    }

    BloodSourceUser _editedBSUser = BloodSourceUser(
      uid: user.uid,
      initEdit: 1,
      email: user.email,
      isDonorFormComplete: user.isDonorFormComplete,
      userType: user.userType,

      //
      diseases: user.diseases,
      piercingOrTattoo: user.piercingOrTattoo,
      pregnantOrBreastFeeding: user.pregnantOrBreastFeeding,
      isDonorEligible: true,

      ///
      bloodGroup: _bloodGroup.value,
      name: nameController.text,
      avatar: _photoUrl.value,
      weight: double.parse(weightController.text),
      height: double.parse(heightController.text),
      age: int.parse(ageController.text),
      phone: phoneController.text,
      gender: _gender.value,

      ///
      city: _locService.city,
      location: _locService.loc,
    );

    await _storeService.getUser(_authService.userUid!);

    switch (user.initEdit) {
      case 0:
      case null:
        final res = await _storeService.updateBloodSourceUser(_editedBSUser);
        _navService.clearStackAndShow(Routes.appLayoutView);
        return res.bSUser!;
      case 1:
        final res = await _storeService.updateBloodSourceUser(_editedBSUser);
        _navService.popRepeated(2);
        return res.bSUser!;
      default:
        return null;
    }
  }

  Future<void> checkConnectivity() async {
    bool isConn = await InternetConnectionChecker().hasConnection;
    switch (isConn) {
      case true:
        _snackbarService.showCustomSnackBar(
          message: 'Yay! You\'re connected!',
          variant: SnackbarType.positive,
          duration: const Duration(seconds: 3),
        );
        notifyListeners();
        break;
      case false:
        _snackbarService.showCustomSnackBar(
          message: 'We are convinced you\'re disconnected. Try again.',
          variant: SnackbarType.negative,
          duration: const Duration(seconds: 3),
        );
        notifyListeners();
        break;
      default:
        null;
    }
  }

  Future<void> init() async {
    _photoUrl.value = user.avatar;
    isConnected = await InternetConnectionChecker().hasConnection;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    weightController.dispose();
    heightController.dispose();
    ageController.dispose();
    phoneController.dispose();
    subscription.cancel();
    super.dispose();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [
        _storeService,
        _mediaService,
        _authService,
      ];
}
