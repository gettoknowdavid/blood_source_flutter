import 'dart:io';

import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/models/blood_group.dart';
import 'package:blood_source/models/gender.dart';
import 'package:blood_source/services/location_service.dart';
import 'package:blood_source/services/media_service.dart';
import 'package:blood_source/services/storage_service.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:blood_source/utils/dialog_type.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class EditProfileViewModel extends ReactiveViewModel with ReactiveServiceMixin {
  EditProfileViewModel() {
    listenToReactiveValues([_image, _photoUrl, _gender]);
  }
  Logger logger = Logger();
  final DialogService _dialogService = locator<DialogService>();
  final StoreService _storeService = locator<StoreService>();
  final MediaService _mediaService = locator<MediaService>();
  final NavigationService _navService = locator<NavigationService>();
  final StorageService _storageService = locator<StorageService>();
  final LocationService _locService = locator<LocationService>();

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

  BloodSourceUser get user => _storeService.bloodUser!;
  String? get city => _locService.city;

  void getImage() async {
    final _pickedFile = await _mediaService.getImage(fromGallery: true);

    if (_pickedFile != null) {
      _image.value = File(_pickedFile.path);
    }

    notifyListeners();
  }

  late TextEditingController nameController =
      TextEditingController(text: user.name);
  late TextEditingController weightController =
      TextEditingController(text: user.weight.toString());
  late TextEditingController heightController =
      TextEditingController(text: user.height.toString());
  late TextEditingController ageController =
      TextEditingController(text: user.age.toString());
  late TextEditingController phoneController =
      TextEditingController(text: user.phone);

  Future getLocation() async {
    await _locService.getPlace();
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

  Future<BloodSourceUser> save() async {
    _dialogService.showCustomDialog(variant: DialogType.loading);

    final name = "${user.uid}.jpg";

    if (_image.value != null) {
      final ref = _storageService.storageRef.child("images/avatar/$name");

      await _storageService.uploadFileToCloud(_image.value!.path, name, ref);

      _photoUrl.value = await _storageService.getFileFromCloud(ref);
    }

    BloodSourceUser _editedBSUser = BloodSourceUser(
      uid: user.uid,
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

    final res = await _storeService.updateBloodSourceUser(_editedBSUser);

    _navService.popRepeated(2);
    logger.log(Level.debug, res);
    return res.bSUser!;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> init() async {
    _photoUrl.value = user.avatar;
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [
        _storeService,
        _mediaService,
      ];
}
