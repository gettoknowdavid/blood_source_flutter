import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/common/app_constants.dart';
import 'package:blood_source/models/blood_group.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:blood_source/models/disease_types.dart';
import 'package:blood_source/models/gender.dart';
import 'package:blood_source/models/user-type.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:blood_source/utils/dialog_type.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DonorFormViewModel extends BaseViewModel with ReactiveServiceMixin {
  Future<void> init() async {}

  DonorFormViewModel() {
    listenToReactiveValues([
      _bloodGroup,
      _disease,
      _pregnantBool,
      _piercingBool,
      _userType,
      _eligible,
    ]);
  }

  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navService = locator<NavigationService>();
  final StoreService _storeService = locator<StoreService>();

  final ReactiveValue<BloodGroup> _bloodGroup =
      ReactiveValue<BloodGroup>(BloodGroup.aPositive);
  final ReactiveValue<List<Disease>> _disease =
      ReactiveValue<List<Disease>>([Disease.none]);
  final ReactiveValue<bool> _pregnantBool = ReactiveValue<bool>(false);
  final ReactiveValue<bool> _piercingBool = ReactiveValue<bool>(false);
  final ReactiveValue<UserType> _userType =
      ReactiveValue<UserType>(UserType.donor);
  final ReactiveValue<bool> _eligible = ReactiveValue<bool>(false);

  BloodGroup get bloodType => _bloodGroup.value;
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  GroupController diseaseController = GroupController(
    isMultipleSelection: true,
    initSelectedItem: [Disease.none],
  );
  List<Disease> get disease => _disease.value;
  bool get pregnantBool => _pregnantBool.value;
  bool get piercingBool => _piercingBool.value;
  UserType get userType => _userType.value;
  bool get eligible => _eligible.value;

  bool isValidated() {
    if (ageController.text.isNotEmpty || weightController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool isWeightApproved() {
    if (int.parse(weightController.text) >= 45) {
      return true;
    } else {
      return false;
    }
  }

  bool isAgeAPproved() {
    if (int.parse(ageController.text) >= 18 &&
        int.parse(ageController.text) <= 60) {
      return true;
    } else {
      return false;
    }
  }

  bool userEligible() {
    if (isWeightApproved() &&
        isAgeAPproved() &&
        _disease.value.contains(Disease.none) &&
        pregnantBool == false &&
        piercingBool == false) {
      return true;
    } else {
      return false;
    }
  }

  void goToApp(BloodSourceUser _user) {
    _navService.clearStackAndShow(
      Routes.editProfileView,
      arguments: EditProfileViewArguments(user: _user, isFirstEdit: true),
    );
  }

  Future onSubmit() async {
    final authUser = FirebaseAuth.instance.currentUser;
    final docUser =
        FirebaseFirestore.instance.collection('users').doc(authUser!.uid);

    // Show loading dialog
    _dialogService.showCustomDialog(variant: DialogType.loading);

    final _bsUser = BloodSourceUser(
      uid: authUser.uid,
      age: int.parse(ageController.text.trim()),
      weight: double.parse(weightController.text.trim()),
      bloodGroup: _bloodGroup.value,
      diseases: _disease.value.map((e) => e.value).toList(),
      piercingOrTattoo: _piercingBool.value,
      pregnantOrBreastFeeding: _pregnantBool.value,
      userType: _userType.value,
      isDonorEligible: true,
      isDonorFormComplete: true,
      email: authUser.email,
      name: authUser.displayName,
      gender: Gender.none,
    );

    await _storeService.updateBloodSourceUser(_bsUser);

    switch (userEligible()) {
      case false:
        //
        // Close loading dialog
        _navService.popRepeated(1);

        // Set user eligibility to false;
        _eligible.value = false;

        // Set user type to recipient
        _userType.value = UserType.recipient;

        // Show disqualified dialog
        _dialogService
            .showDialog(
              description: AppConstants.unqualifiedMessage,
              cancelTitle: 'Cancel',
              buttonTitle: 'Continue',
              barrierDismissible: true,
            )
            .then((value) => value!.confirmed ? goToApp(_bsUser) : null);
        notifyListeners();
        break;
      case true:
        //
        // Close loading dialog
        _navService.popRepeated(1);

        // Set user eligibility to false;
        _eligible.value = true;

        // Set user type to donor
        _userType.value = UserType.donor;

        // Show qualified dialog
        _dialogService
            .showDialog(
              description: AppConstants.qualifiedMessage,
              buttonTitle: 'Next',
            )
            .then((value) => value!.confirmed ? goToApp(_bsUser) : null);
        notifyListeners();
        break;
      default:
        return null;
    }
  }

  void Function(BloodGroup?)? onBloodGroupChanged(BloodGroup? newValue) {
    _bloodGroup.value = newValue!;
    notifyListeners();
    return null;
  }

  dynamic Function(dynamic data)? onDiseaseChanged(dynamic data) {
    if (data.contains(Disease.none)) {
      _disease.value.clear();
      _disease.value = [Disease.none];
      diseaseController.deselectValues([
        Disease.cancer,
        Disease.cardiacDisease,
        Disease.severeLungDisease,
        Disease.hepatitisB,
        Disease.hepatitisC,
        Disease.std,
      ]);
      notifyListeners();
      return null;
    } else {
      _disease.value = data;
      return null;
    }
  }

  void Function(bool? data)? onPregnantChanged(bool? data) {
    _pregnantBool.value = data!;
    return null;
  }

  void Function(bool? data)? onPiercingChanged(bool? data) {
    _piercingBool.value = data!;
    return null;
  }

  @override
  void dispose() {
    ageController.dispose();
    weightController.dispose();
    diseaseController.deselectAll();
    super.dispose();
  }
}
