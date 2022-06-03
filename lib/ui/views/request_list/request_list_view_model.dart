import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/models/request.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RequestListViewModel extends ReactiveViewModel with ReactiveServiceMixin {
  RequestListViewModel() {
    listenToReactiveValues([_compatible]);
  }

  final NavigationService _navService = locator<NavigationService>();
  final StoreService _storeService = locator<StoreService>();

  final ReactiveValue<List<Request>?> _requests =
      ReactiveValue<List<Request>?>([]);
  List<Request>? get requests => _requests.value;

  final ReactiveValue<bool> _compatible = ReactiveValue<bool>(true);
  bool get compatible => _compatible.value;

  goToDetails(Request req) {
    _navService.navigateTo(
      Routes.requestDetailsView,
      arguments: RequestDetailsViewArguments(request: req),
    );
  }

  Future<void> init() async {
    _compatible.listen((v) async {
      if (v) {
        setBusy(true);
        await getCompatibleRequests();

        setBusy(false);
      } else {
        setBusy(true);
        await getRequests();

        setBusy(false);
      }
    });
  }

  Future longUpdateStuff() async {
    var result = await runBusyFuture(getCompatibleRequests());
    return result;
  }

  void Function(bool?)? onCompatibilityChanged(bool? value) {
    _compatible.value = value!;
    notifyListeners();
    return null;
  }

  Future<List<Request>?> getCompatibleRequests() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final _storeResult = await _storeService.getUser(uid);
    final _user = _storeResult!.bSUser!;
    print(_user.bloodGroup!);
    final _r = await _storeService.getCompatibleRequests(_user.bloodGroup!);
    if (_r.requests != null) {
      _requests.value = _r.requests;
      return _requests.value;
    } else {
      _requests.value = [];
      return _requests.value;
    }
  }

  Future<List<Request>?> getRequests() async {
    final result = await _storeService.getRequests();
    if (result.isRequestsEmpty) {
      return [];
    } else {
      _requests.value = result.requests!;
      return _requests.value;
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_storeService];
}
