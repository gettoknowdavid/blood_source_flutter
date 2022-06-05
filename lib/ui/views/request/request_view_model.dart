import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/models/blood_group.dart';
import 'package:blood_source/models/request.dart';
import 'package:blood_source/models/request_user.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:blood_source/ui/views/donor/donor_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:uuid/uuid.dart';

class RequestViewModel extends ReactiveViewModel {
  final NavigationService _navService = locator<NavigationService>();

  bool showContact = false;

  bool compatible = true;

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
    showContact = value!;
    notifyListeners();
    return null;
  }

  void Function(bool?)? onCompatibilityChanged(bool? value) {
    compatible = value!;
    _storeService.setCompatible(value);
    notifyListeners();
    return null;
  }

  final List<BloodGroup> bgList =
      BloodGroup.values.where((e) => e != BloodGroup.none).toList();

  Future<void> searchDonations() async {
    Request request = Request(
      user: RequestUser(
        uid: user.uid!,
        name: user.name!,
        avatar: user.avatar!,
        location: user.location!,
      ),
      uid: const Uuid().v4(),
      bloodGroup: bloodGroup,
      showContactInfo: showContact,
      requestGranted: false,
    );

    _storeService.setRequest(request);

    _navService.navigateToView(
      DonorView(fromRequestView: true, request: request),
    );
  }

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
