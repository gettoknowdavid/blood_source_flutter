import 'dart:async';

import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/models/request.dart';
import 'package:blood_source/services/request_service.dart';
import 'package:blood_source/ui/shared/setup_snack_bar_ui.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RequestListViewModel extends FutureViewModel<RequestResult> {
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

  final ReactiveValue<bool?> _hasConn = ReactiveValue<bool?>(null);
  bool get hasConn => _hasConn.value!;

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
    notifySourceChanged();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_requestService];

  // @override
  // Stream<QuerySnapshot<Request?>> get stream => compatible
  //     ? _requestService.getCompatibleRequests().compatibleStream!
  //     : _requestService.getRequests();

  Future<RequestResult> getRequestsFromService() async {
    // if (compatible)
    return await _requestService.getRequests();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Future<RequestResult> futureToRun() => getRequestsFromService();
}
