import 'dart:async';

import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/models/blood_group.dart';
import 'package:blood_source/models/request.dart';
import 'package:blood_source/models/request_user.dart';
import 'package:blood_source/services/request_service.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:blood_source/ui/shared/setup_snack_bar_ui.dart';
import 'package:blood_source/ui/views/donor/donor_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:uuid/uuid.dart';

class RequestViewModel extends ReactiveViewModel {
  RequestViewModel() {
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

  final NavigationService _navService = locator<NavigationService>();
  final StoreService _storeService = locator<StoreService>();
  final RequestService _requestService = locator<RequestService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

  bool? isConnected;

  BloodSourceUser get user => _storeService.bsUser!;

  late BloodGroup bloodGroup = _storeService.bsUser!.bloodGroup!;

  void Function(BloodGroup?)? onBloodGroupChanged(BloodGroup? newValue) {
    bloodGroup = newValue!;
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
      requestGranted: false,
    );

    _requestService.setRequest(request);

    _navService.navigateToView(
      DonorView(fromRequestView: true, request: request),
    );
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

  Future longUpdateStuff() async {
    // Sets busy to true before starting future and sets it to false after executing
    // You can also pass in an object as the busy object. Otherwise it'll use the ViewModel
    isConnected = await InternetConnectionChecker().hasConnection;
    notifyListeners();
    var result = await runBusyFuture(
      _storeService.getUser(FirebaseAuth.instance.currentUser!.uid),
    );

    return result;
  }

  Future<void> init() async {
    await longUpdateStuff();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_storeService];

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
