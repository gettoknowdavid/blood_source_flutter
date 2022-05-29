import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/models/blood_group.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RequestViewModel extends ReactiveViewModel with ReactiveServiceMixin {
  RequestViewModel() {
    listenToReactiveValues([_showPhone]);
  }
  final NavigationService _navService = locator<NavigationService>();

  final ReactiveValue<bool> _showPhone = ReactiveValue<bool>(false);
  bool get showPhone => _showPhone.value;

  final StoreService _storeService = locator<StoreService>();
  BloodSourceUser get user => _storeService.bloodUser!;

  late BloodGroup bloodGroup = _storeService.bloodUser!.bloodGroup!;
  TextEditingController reasonController = TextEditingController();

  void Function(BloodGroup?)? onBloodGroupChanged(BloodGroup? newValue) {
    bloodGroup = newValue!;
    notifyListeners();
    return null;
  }

  void Function(BloodGroup)? onBGChanged(BloodGroup bg) {
    bloodGroup = bg;
    notifyListeners();
    return null;
  }

  void Function(bool?)? onShowPhoneChanged(bool? value) {
    _showPhone.value = value!;
    notifyListeners();
    return null;
  }

  void goToDonorList() => _navService.navigateTo(Routes.donorView);

  final List<BloodGroup> bgList =
      BloodGroup.values.where((e) => e != BloodGroup.none).toList();

  Future<void> init() async {
    await longUpdateStuff();
  }

  Future longUpdateStuff() async {
    // Sets busy to true before starting future and sets it to false after executing
    // You can also pass in an object as the busy object. Otherwise it'll use the ViewModel
    var result = await runBusyFuture(
      _storeService.getUser(FirebaseAuth.instance.currentUser!.uid),
    );

    return result;
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_storeService];
}
