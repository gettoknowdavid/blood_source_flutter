// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/models/request.dart';
import 'package:blood_source/services/request_service.dart';
import 'package:blood_source/ui/shared/setup_snack_bar_ui.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

const String _RequestsFuture = '_requests_future_';
const String _CompatibleFuture = '_compatible_future_';

class RequestListViewModel extends MultipleFutureViewModel {
  RequestListViewModel() {
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
  final NavigationService navService = locator<NavigationService>();
  final RequestService _requestService = locator<RequestService>();

  bool? isConnected;
  bool compatible = true;

  RequestResult get fetchedRequests => dataMap?[_RequestsFuture];
  RequestResult get fetchedCompatibleRequests => dataMap?[_CompatibleFuture];

  bool get fetchingRequests => busy(_RequestsFuture);
  bool get fetchingCompatible => busy(_CompatibleFuture);

  goToDetails(Request req) {
    navService.navigateTo(
      Routes.requestDetailsView,
      arguments: RequestDetailsViewArguments(request: req),
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

  void onCompatibilityChanged() {
    compatible = !compatible;
    notifyListeners();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Map<String, Future Function()> get futuresMap => {
        _RequestsFuture: _requestService.getRequests,
        _CompatibleFuture: _requestService.getCompatibleRequests,
      };
}
