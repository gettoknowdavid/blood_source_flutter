import 'dart:async';

import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/models/request.dart';
import 'package:blood_source/services/request_service.dart';
import 'package:blood_source/ui/shared/setup_snack_bar_ui.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MyRequestsListViewModel extends FutureViewModel<RequestResult> {
  MyRequestsListViewModel() {
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

  final SnackbarService _snackbarService = locator<SnackbarService>();
  final RequestService _requestService = locator<RequestService>();

  bool? isConnected;

  Future<void> delete(Request request) async {
    if (data != null) {
      await _requestService.deleteRequest(request.uid);

      final index = data!.myRequests!.indexOf(request);
      data!.myRequests!.removeAt(index);
      notifyListeners();
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
        break;
      case false:
        _snackbarService.showCustomSnackBar(
          message: 'We are convinced you\'re disconnected. Try again.',
          variant: SnackbarType.negative,
          duration: const Duration(seconds: 3),
        );
        break;
      default:
        null;
    }
  }

  Future<void> init() async {
    isConnected = await InternetConnectionChecker().hasConnection;
    notifyListeners();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_requestService];

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Future<RequestResult> futureToRun() => _requestService.getMyRequests();
}
